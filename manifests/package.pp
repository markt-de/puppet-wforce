# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include wforce::package
class wforce::package {
  if ($wforce::package_manage) {
    package { 'wforce_package':
      ensure => $wforce::package_ensure,
      name   => $wforce::package_name,
    }
  }
}
