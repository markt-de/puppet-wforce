# puppet-wforce

[![Build Status](https://github.com/markt-de/puppet-wforce/actions/workflows/ci.yaml/badge.svg)](https://github.com/markt-de/puppet-wforce/actions/workflows/ci.yaml)
[![Puppet Forge](https://img.shields.io/puppetforge/v/fraenki/wforce.svg)](https://forge.puppetlabs.com/fraenki/wforce)
[![Puppet Forge](https://img.shields.io/puppetforge/f/fraenki/wforce.svg)](https://forge.puppetlabs.com/fraenki/wforce)

#### Table of Contents

1. [Overview](#overview)
2. [Requirements](#requirements)
3. [Usage](#usage)
    - [Beginning with wforce](#beginning-with-wforce)
    - [Test wforce](#test-wforce)
    - [Dovecot integration](#dovecot-integration)
    - [Custom rules](#custom-rules)
4. [Reference](#reference)
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

Classes and parameters are documented in [REFERENCE.md](REFERENCE.md).

## Development

### Contributing

Please use the GitHub issues functionality to report any bugs or requests for new features. Feel free to fork and submit pull requests for potential contributions.
