# @summary Setup configuration files
# @api private
class wforce::config {
  assert_private()

  if $wforce::config_manage {
    file { $wforce::config_file:
      ensure  => file,
      mode    => $wforce::config_mode,
      content => epp($wforce::config_template),
      owner   => $wforce::user,
      group   => $wforce::group,
      notify  => Class['wforce::service'],
      require => Class['wforce::package'],
    }
  }
}
