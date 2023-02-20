# @summary Install and configure weakforced
#
# @param acls
#   A list of ACLs for the weakforced service.
#
# @param address
#   The listen address for the weakforced webserver.
#
# @param config_file
#   Path to the configuration file.
#
# @param config_manage
#   Whether configuration files should be managed.
#
# @param config_mode
#   File mode to be used for config files.
#
# @param config_template
#   Specifies the EPP template to use.
#
# @param database_defaults
#   Default values for database configuration.
#
# @param databases
#   A list of databases.
#
# @param fieldmaps
#   A list of fieldmaps.
#
# @param functions
#   A list of Lua functions (Lua source code).
#
# @param function_args
#   A list of arguments that are passed to functions.
#
# @param group
#   The group under which the service will run.
#
# @param package_ensure
#   The desired state of the package resource.
#
# @param package_manage
#   Whether package installation/removal should be managed.
#
# @param package_name
#   The name of the package.
#
# @param password
#   The weakforced API password.
#
# @param port
#   The weakforced port number.
#
# @param repo_manage
#   Whether package repositories should be managed.
#
# @param service_ensure
#   The desired state of the service resource.
#
# @param service_name
#   The name of the service.
#
# @param service_manage
#   Whether the service should be managed.
#
# @param siblings
#   A list of replication targets.
#
# @param siblings_address
#   The replication address of the local service.
#
# @param siblings_key
#   The credential key used for replication.
#
# @param siblings_port
#   The replication port of the local service.
#
# @param socket_address
#   The listen address of the control socket.
#
# @param socket_port
#   The port number of the control socket.
#
# @param sync_enable
#   Whether to enable replication of databases from remote servers.
#
# @param sync_host
#   The source host for database replication.
#
# @param sync_myip
#   The IP address of the local instance.
#
# @param sync_password
#   The password used for replication.
#
# @param sync_port
#   The port used for database replication.
#
# @param sync_uptime
#   The minimum uptime (in seconds) of a host before replication is considered.
#
# @param use_functions
#   A list of Lua functions that will be used to handle weakforced commands.
#
# @param user
#   The user under which the service will run.
#
# @param whitelist
#   A list of subnets that are allowed to communicate with the weakforce service.
#
class wforce (
  Array $acls,
  String $address,
  String $config_file,
  Boolean $config_manage,
  String $config_mode,
  String $config_template,
  Hash $database_defaults,
  Hash $databases,
  Hash $fieldmaps,
  Hash $function_args,
  Hash $functions,
  String $group,
  String $package_ensure,
  Boolean $package_manage,
  String $package_name,
  String $password,
  Integer $port,
  Boolean $repo_manage,
  Enum['absent', 'running', 'stopped'] $service_ensure,
  String $service_name,
  Boolean $service_manage,
  Array $siblings,
  String $siblings_address,
  Integer $siblings_port,
  String $socket_address,
  Integer $socket_port,
  Boolean $sync_enable,
  Integer $sync_uptime,
  Hash $use_functions,
  String $user,
  Array $whitelist,
  # optional parameters
  Optional[String] $siblings_key = undef,
  Optional[String] $sync_host = undef,
  Optional[String] $sync_myip = undef,
  Optional[String] $sync_password = undef,
  Optional[Integer] $sync_port = undef,
) {
  Class { 'wforce::repo': }
  -> Class { 'wforce::package': }
  -> Class { 'wforce::config': }
  ~> Class { 'wforce::service': }
}
