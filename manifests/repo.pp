# @summary Setup software repositories
# @api private
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
  assert_private()

  if $repo_manage {
    case $facts['os']['family'] {
      'Debian': {
        apt::source { $module_name:
          location => inline_epp($apt_location),
          release  => $apt_release,
          repos    => $apt_repos,
          key      => {
            'id'     => $apt_key,
            'server' => $apt_key_server,
          },
          include  => {
            'src' => $apt_include_src,
          },
        }
      }
      'RedHat': {
        yumrepo { $module_name:
          descr    => $yum_descr,
          baseurl  => inline_epp($yum_baseurl),
          gpgkey   => $yum_gpgkey,
          enabled  => $yum_enabled,
          gpgcheck => $yum_gpgcheck,
        }
      }
      default: {
        fail("Operating system ${facts['os']['family']} is not currently supported")
      }
    }
  }
}
