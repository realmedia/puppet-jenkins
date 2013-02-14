# Class: jenkins::params
#
#
class jenkins::params {
  $version      = 'present'
  $lts          = true
  $http_port    = 8080
  $jenkins_user = 'jenkins'
  $jenkins_home  = '/var/lib/jenkins'

  case $::osfamily {
    Debian: { 
      $jenkins_group = 'nogroup'
      $java_pkg      = 'openjdk-6-jdk'
    }
    RedHat: { 
      $jenkins_group = 'jenkins'
      $java_pkg      = 'java-1.6.0-openjdk'
    }
    default: {
      fail( "Unsupported OS family: ${::osfamily}" )
    }
  }
}