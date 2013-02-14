# Class: jenkins
#
#
class jenkins (
  $version       = $jenkins::params::version,
  $lts           = $jenkins::params::lts,
  $jenkins_user  = $jenkins::params::jenkins_user,
  $jenkins_group = $jenkins::params::jenkins_group,
  $jenkins_home  = $jenkins::params::jenkins_home,
  $http_port     = $jenkins::params::http_port
) inherits jenkins::params {

  class { 'jenkins::repository':
    lts => $lts,
  }

  if ! defined(Package[$jenkins::params::java_pkg]) {
    package { $jenkins::params::java_pkg: ensure => installed; }
  }

  package { 'jenkins':
    ensure  => $version,
    require => [Class['jenkins::repository'], Package[$jenkins::params::java_pkg]],
  }

  service { 'jenkins':
    ensure     => 'running',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

  file { "${jenkins_home}/updates":
    ensure  => directory,
    owner   => $jenkins_user,
    group   => $jenkins_group,
    require => Package['jenkins'],
  }

  exec { 'jenkins-update-center':
    command     => "wget -qO- http://updates.jenkins-ci.org/update-center.json | sed '1d;$d' > ${jenkins_home}/updates/default.json && chown ${jenkins_user}:${jenkins_group} ${jenkins_home}/updates/default.json",
    creates     => "${jenkins_home}/updates/default.json",
    timeout     => 0,
    require     => File["${jenkins_home}/updates"],
    notify      => Service['jenkins'],
  }
}