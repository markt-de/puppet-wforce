# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include wforce::service
class wforce::service {
  $service_enable = $wforce::service_ensure ? {
    'running' => true,
    'absent'  => false,
    'stopped' => false,
    'undef'   => undef,
    default   => true,
  }

  if $wforce::service_manage {
    service { 'wforce_service':
      ensure    => $wforce::service_ensure,
      name      => $wforce::service_name,
      enable    => $service_enable,
      hasstatus => true,
    }
  }
}
