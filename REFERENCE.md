# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

#### Public Classes

* [`wforce`](#wforce): Install and configure weakforced

#### Private Classes

* `wforce::config`: Setup configuration files
* `wforce::package`: Install packages
* `wforce::repo`: Setup software repositories
* `wforce::service`: Manage the system service

## Classes

### <a name="wforce"></a>`wforce`

Install and configure weakforced

#### Parameters

The following parameters are available in the `wforce` class:

* [`acls`](#-wforce--acls)
* [`address`](#-wforce--address)
* [`config_file`](#-wforce--config_file)
* [`config_manage`](#-wforce--config_manage)
* [`config_mode`](#-wforce--config_mode)
* [`config_template`](#-wforce--config_template)
* [`database_defaults`](#-wforce--database_defaults)
* [`databases`](#-wforce--databases)
* [`fieldmaps`](#-wforce--fieldmaps)
* [`functions`](#-wforce--functions)
* [`function_args`](#-wforce--function_args)
* [`group`](#-wforce--group)
* [`package_ensure`](#-wforce--package_ensure)
* [`package_manage`](#-wforce--package_manage)
* [`package_name`](#-wforce--package_name)
* [`password`](#-wforce--password)
* [`port`](#-wforce--port)
* [`repo_manage`](#-wforce--repo_manage)
* [`service_ensure`](#-wforce--service_ensure)
* [`service_name`](#-wforce--service_name)
* [`service_manage`](#-wforce--service_manage)
* [`siblings`](#-wforce--siblings)
* [`siblings_address`](#-wforce--siblings_address)
* [`siblings_key`](#-wforce--siblings_key)
* [`siblings_port`](#-wforce--siblings_port)
* [`socket_address`](#-wforce--socket_address)
* [`socket_port`](#-wforce--socket_port)
* [`sync_enable`](#-wforce--sync_enable)
* [`sync_host`](#-wforce--sync_host)
* [`sync_myip`](#-wforce--sync_myip)
* [`sync_password`](#-wforce--sync_password)
* [`sync_port`](#-wforce--sync_port)
* [`sync_uptime`](#-wforce--sync_uptime)
* [`use_functions`](#-wforce--use_functions)
* [`user`](#-wforce--user)
* [`whitelist`](#-wforce--whitelist)

##### <a name="-wforce--acls"></a>`acls`

Data type: `Array`

A list of ACLs for the weakforced service.

##### <a name="-wforce--address"></a>`address`

Data type: `String`

The listen address for the weakforced webserver.

##### <a name="-wforce--config_file"></a>`config_file`

Data type: `String`

Path to the configuration file.

##### <a name="-wforce--config_manage"></a>`config_manage`

Data type: `Boolean`

Whether configuration files should be managed.

##### <a name="-wforce--config_mode"></a>`config_mode`

Data type: `String`

File mode to be used for config files.

##### <a name="-wforce--config_template"></a>`config_template`

Data type: `String`

Specifies the EPP template to use.

##### <a name="-wforce--database_defaults"></a>`database_defaults`

Data type: `Hash`

Default values for database configuration.

##### <a name="-wforce--databases"></a>`databases`

Data type: `Hash`

A list of databases.

##### <a name="-wforce--fieldmaps"></a>`fieldmaps`

Data type: `Hash`

A list of fieldmaps.

##### <a name="-wforce--functions"></a>`functions`

Data type: `Hash`

A list of Lua functions (Lua source code).

##### <a name="-wforce--function_args"></a>`function_args`

Data type: `Hash`

A list of arguments that are passed to functions.

##### <a name="-wforce--group"></a>`group`

Data type: `String`

The group under which the service will run.

##### <a name="-wforce--package_ensure"></a>`package_ensure`

Data type: `String`

The desired state of the package resource.

##### <a name="-wforce--package_manage"></a>`package_manage`

Data type: `Boolean`

Whether package installation/removal should be managed.

##### <a name="-wforce--package_name"></a>`package_name`

Data type: `String`

The name of the package.

##### <a name="-wforce--password"></a>`password`

Data type: `String`

The weakforced API password.

##### <a name="-wforce--port"></a>`port`

Data type: `Integer`

The weakforced port number.

##### <a name="-wforce--repo_manage"></a>`repo_manage`

Data type: `Boolean`

Whether package repositories should be managed.

##### <a name="-wforce--service_ensure"></a>`service_ensure`

Data type: `Enum['absent', 'running', 'stopped']`

The desired state of the service resource.

##### <a name="-wforce--service_name"></a>`service_name`

Data type: `String`

The name of the service.

##### <a name="-wforce--service_manage"></a>`service_manage`

Data type: `Boolean`

Whether the service should be managed.

##### <a name="-wforce--siblings"></a>`siblings`

Data type: `Array`

A list of replication targets.

##### <a name="-wforce--siblings_address"></a>`siblings_address`

Data type: `String`

The replication address of the local service.

##### <a name="-wforce--siblings_key"></a>`siblings_key`

Data type: `Optional[String]`

The credential key used for replication.

Default value: `undef`

##### <a name="-wforce--siblings_port"></a>`siblings_port`

Data type: `Integer`

The replication port of the local service.

##### <a name="-wforce--socket_address"></a>`socket_address`

Data type: `String`

The listen address of the control socket.

##### <a name="-wforce--socket_port"></a>`socket_port`

Data type: `Integer`

The port number of the control socket.

##### <a name="-wforce--sync_enable"></a>`sync_enable`

Data type: `Boolean`

Whether to enable replication of databases from remote servers.

##### <a name="-wforce--sync_host"></a>`sync_host`

Data type: `Optional[String]`

The source host for database replication.

Default value: `undef`

##### <a name="-wforce--sync_myip"></a>`sync_myip`

Data type: `Optional[String]`

The IP address of the local instance.

Default value: `undef`

##### <a name="-wforce--sync_password"></a>`sync_password`

Data type: `Optional[String]`

The password used for replication.

Default value: `undef`

##### <a name="-wforce--sync_port"></a>`sync_port`

Data type: `Optional[Integer]`

The port used for database replication.

Default value: `undef`

##### <a name="-wforce--sync_uptime"></a>`sync_uptime`

Data type: `Integer`

The minimum uptime (in seconds) of a host before replication is considered.

##### <a name="-wforce--use_functions"></a>`use_functions`

Data type: `Hash`

A list of Lua functions that will be used to handle weakforced commands.

##### <a name="-wforce--user"></a>`user`

Data type: `String`

The user under which the service will run.

##### <a name="-wforce--whitelist"></a>`whitelist`

Data type: `Array`

A list of subnets that are allowed to communicate with the weakforce service.

