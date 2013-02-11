# Class: jenkins
#
#
class jenkins (
  $version = $jenkins::params::version,
  $lts     = $jenkins::params::lts
) inherits jenkins::params {

  class { 'jenkins::repository':
    lts => $lts,
  }

  package { 'jenkins':
    ensure => $version,
  }

  service { 'jenkins':
    ensure     => 'running',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

  Class['jenkins::repository'] -> Package['jenkins'] -> Service['jenkins']
}