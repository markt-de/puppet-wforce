# puppet-wforce

[![Build Status](https://travis-ci.org/fraenki/puppet-wforce.png?branch=master)](https://travis-ci.org/fraenki/puppet-wforce)

#### Table of Contents

1. [Overview](#overview)
2. [Requirements](#requirements)
3. [Usage](#usage)
    - [Beginning with wforce](#beginning-with-wforce)
    - [Custom repository configuration](#custom-repository-configuration)
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

## Reference

### Public Classes

#### Class: `wforce`

TBD

### Private Classes

#### Class: `wforce::config`

#### Class: `wforce::package`

#### Class: `wforce::service`

#### Class: `wforce::repo`


## Development

### Contributing

Please use the GitHub issues functionality to report any bugs or requests for new features. Feel free to fork and submit pull requests for potential contributions.
