# @summary Install packages
# @api private
class wforce::package {
  assert_private()

  if ($wforce::package_manage) {
    package { 'wforce_package':
      ensure => $wforce::package_ensure,
      name   => $wforce::package_name,
    }
  }
}
