# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include wforce::config
class wforce::config {
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
