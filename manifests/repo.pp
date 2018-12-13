# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include wforce::repo
class wforce::repo (
  Boolean $repo_manage = $wforce::repo_manage,
  # APT
  Optional[Boolean] $apt_include_src = undef,
  Optional[String] $apt_key = undef,
  Optional[String] $apt_key_server = undef,
  Optional[String] $apt_location = undef,
  Optional[String] $apt_release = undef,
  Optional[String] $apt_repos = undef,
  # YUM
  Optional[String] $yum_baseurl = undef,
  Optional[String] $yum_descr = undef,
  Optional[Integer] $yum_enabled = undef,
  Optional[Integer] $yum_gpgcheck = undef,
  Optional[String] $yum_gpgkey = undef,
) {
  if $repo_manage {
    case $facts['os']['family'] {
      'Debian': {
        apt::source { "${module_name}":
          location => inline_epp($params['apt_location']),
          release  => $params['apt_release'],
          repos    => $params['apt_repos'],
          key      => {
            'id'     => $params['apt_key'],
            'server' => $params['apt_server'],
          },
          include  => {
            'src' => $params['apt_include_src'],
          },
        }
      }
      'RedHat': {
        yumrepo { "${module_name}":
          descr    => $params['yum_descr'],
          baseurl  => inline_epp($params['yum_baseurl']),
          gpgkey   => $params['yum_gpgkey'],
          enabled  => $params['yum_enabled'],
          gpgcheck => $params['yum_gpgcheck'],
        }
      }
      default: {
        fail("Operating system ${facts['os']['family']} is not currently supported")
      }
    }
  }
}
