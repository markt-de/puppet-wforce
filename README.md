# puppet-wforce

[![Build Status](https://travis-ci.org/fraenki/puppet-wforce.png?branch=master)](https://travis-ci.org/fraenki/puppet-wforce)

#### Table of Contents

1. [Overview](#overview)
2. [Requirements](#requirements)
3. [Usage](#usage)
    - [Beginning with wforce](#beginning-with-wforce)
    - [Test wforce](#test-wforce)
    - [Dovecot integration](#dovecot-integration)
    - [Custom rules](#custom-rules)
4. [Reference](#reference)
    - [Public classes](#public-classes)
        - [wforce](#class-wforce)
    - [Private classes](#private-classes)
        - [wforce::config](#class-wforceconfig)
        - [wforce::package](#class-wforcepackage)
        - [wforce::service](#class-wforceservice)
        - [wforce::repo](#class-wforcerepo)
5. [Development](#development)
    - [Contributing](#contributing)

## Overview

This module will setup the weakforced Anti-Abuse server, also known as "wforce".

## Requirements

* Puppet 5 or higher
* Access to wforce binary packages (either through a subscription or custom builds)

## Usage

### Beginning with wforce

Basic usage requires only a password for the wforce HTTP server:

    class { 'wforce':
        password => 'secretpassword'
    }

Furthermore, a number of simple options are available:

    class { 'wforce':
        # Add networks to the access control list for the HTTP server.
        acls => [ '172.16.99.0/24', '10.100.200.0/24' ],

        # Change settings of the default databases (or add new databases).
        databases => {
          24HourDB => {
            max_size => 750000,
            v4prefix => 24,
          },
          MyDB => {
            window_size: 900
            num_windows: 32
            max_size: 500000
            field_map: 'default_field_map'
            replication: false
          },
        },

        # Replicate changes to db and blacklist to these hosts.
        siblings     => [ "10.99.0.1:4001:udp", "10.99.0.2:4001:udp", "10.99.0.3:4001:udp" ],
        siblings_key => 'anothersecretpassword',

        # On startup, try to replicate databases from the following host.
        sync_enable   => true,
        sync_host     => '10.99.0.1',
        sync_password => 'secretpassword',
        sync_uptime   => 3600,

        # Whitelist certain IP networks and hosts to avoid accidential blacklisting
        whitelist => [ "10.199.0.0/24", "10.222.0.123/32" ],
    }

### Test wforce
Use cURL to test if wforce is running and accepting authentication requests:

    curl -X POST -H "Content-Type: application/json" --data '{"login":"user@example.com", "remote": "10.12.34.56", "pwhash":"1234"}' http://127.0.0.1:8084/?command=allow -u wforce:SECRETPASSWORD

### Dovecot integration
Dovecot will use Basic Authentication when communicating with wforce, so we need to generate a base64 encoded authentication string:

    echo -n 'wforce:secretpassword' | base64

Next add the following lines to `dovecot.conf` and restart dovecot afterwards:

    auth_policy_server_url = http://localhost:8084/
    auth_policy_hash_nonce = <insert_a_long_random_string_here>
    auth_policy_server_api_header = Authorization: Basic <insert_base64_string_here>
    auth_policy_server_timeout_msecs = 2000
    auth_policy_hash_mech = sha256
    auth_policy_request_attributes = login=%{requested_username} pwhash=%{hashed_password} remote=%{rip} device_id=%{client_id} protocol=%s
    auth_policy_reject_on_fail = no
    auth_policy_hash_truncate = 8
    auth_policy_check_before_auth = yes
    auth_policy_check_after_auth = yes
    auth_policy_report_after_auth = yes

Be sure to check the dovecot log to ensure that dovecot is able to communicate with wforce.

I recommend [oxc/puppet-dovecot](https://github.com/oxc/puppet-dovecot) to manage dovecot.

### Custom rules
This module contains the example rules from wforce's source distribution. They are not particular useful to block serious attacks, but they should give you an idea how wforce works.

Once you want to deploy your own rules, simply override the default ones:

    wforce::functions:
      report: |+
        if (lt.success)
        then
          sdb:twAdd(lt.login, "countLogins", 1)
          sdb:twAdd(lt.remote, "countLogins", 1)
        end
    ...

## Reference

### Public Classes

#### Class: `wforce`

* `acls`: Specifies additional networks that should be added to the access control list. Valid options: a hash. Defaults to a list of local networks.
* `address`: Specifies the address to use for wforce. Valid options: a string. Default: `0.0.0.0`.
* `config_file`: Specifies the configuration file to use for wforce. Valid options: a string. Default: `/etc/wforce/wforce.conf`.
* `config_manage`: A flag to indicate if we should manage the configuration file. Set this to false if you wish to manage the file elsewhere. Valid options: `true` and `false`. Default: `true`.
* `config_mode`: Specifies the file mode bits to use for the configuration file. Valid options: a string. Default: `0600`.
* `config_template`: Specifies the template to use when generating the configuration file. Change this if you wish to use a custom template. Valid options: a string.
* `database_defaults`: Specifies a list of default values for databases. The module will fallback to these values if a database configuration is missing a specific value. Valid options: a hash.
* `databases`: Specifies a list of internal databases for wforce. Valid options: a hash.
* `fieldmaps`: Specifies a list of fieldmaps to be used for databases. Valid options: a hash.
* `function_args`: Specifies alternative arguments that should be used for one or more Lua functions. Valid options: a hash.
* `functions`: Specifies a list of Lua functions that should be added to wforce. Valid options: a hash.
* `group`: Specifies the name of the group to use for wforce. Valid options: a string. Default: `wforce`.
* `package_ensure`: Specifies the ensure state for packages. Valid options: all values supported by the package type. Default: `installed`.
* `package_manage`: A flag to indicate if we should manage the package installation. Valid options: `true` and `false`. Default: `true`.
* `package_name`: Specifies the name of the package to install. Valid options: a string. Default: A version- and OS-specific value.
* `password`: Specifies the password to set for the wforce HTTP server. Valid options: a string.
* `repo_manage`: A flag to indicate if we should manage the package repository. Valid options: `true` and `false`. Default: `true`.
* `service_ensure`: Specifies the ensure state for the service. Valid options: all values supported by the service type. Default: `running`.
* `service_name`: Specifies the name of the service. Valid options: a string: Default: `wforce`.
* `service_manage`: A flag to indicate if we should manage the service. Valid options: `true` and `false`. Default: `true`.
* `siblings`: Specifies a list of hosts that should receive updates to the stats db and blacklist. Valid options: an array.
* `siblings_address`: Specifies the local address to use when communicating with other hosts. Valid options: a string. Default: `{networking.ip}`.
* `siblings_key`: Specifies the authentication key to use when communicating with other hosts. Valid options: a string.
* `siblings_port`: Specifies the port to use when communicating with other hosts. Valid options: an integer.
* `socket_address`: Specifies the address to use for control connections. Valid options: a string. Default: `0.0.0.0`.
* `socket_port`: Specifies the port to use for control connections. Valid options: an integrer. Default: `4004`.
* `sync_enable`: A flag to indicate if we should sync the database from a sync host. Valid options: `true` and `false`. Default: `false`.
* `sync_host`: Specifies the address of the remote sync host. Valid options: a string.
* `sync_myip`: Specifies the local address that should receive the database from the remote host. Valid options: a string. Default: `{networking.ip}`.
* `sync_password`: Specifies the password to use for the remote sync host. Valid options: a string.
* `sync_port`: Specifies the port of the remote sync host. Valid options: an integer.
* `sync_uptime`: Specifies the minimum time (in seconds) that any sync host must have been up for it to be able to send use the contents of its databases. Valid options: an integer. Default: `3600`.
* `use_function`: Map Lua functions to wforce functionality. Valid option: a hash.
* `user`: Specifies the name of the user to use for wforce. Valid options: a string. Default: `wforce`.
* `whitelist`: Specifies a list of IP networks that should be whitelisted (i.e. to avoid accidential blacklisting). Valid options: an array. Default: a list of local networks.

### Private Classes

#### Class: `wforce::config`

#### Class: `wforce::package`

#### Class: `wforce::service`

#### Class: `wforce::repo`


## Development

### Contributing

Please use the GitHub issues functionality to report any bugs or requests for new features. Feel free to fork and submit pull requests for potential contributions.
