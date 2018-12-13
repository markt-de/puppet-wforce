# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include wforce
class wforce (
  Array $acls,
  String $address,
  String $config_file,
  Boolean $config_manage,
  String $config_mode,
  String $config_template,
  Hash $databases,
  Hash $fieldmaps,
  Hash $functions,
  Hash $functions_args,
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
){
  Class { 'wforce::repo':  }
  -> Class { 'wforce::package':  }
  -> Class { 'wforce::config': }
  ~> Class { 'wforce::service': }
}
