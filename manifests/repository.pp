# Class: jenkins::repository
#
#
class jenkins::repository ($lts = true) {
  case $::osfamily {
    Debian: {
      if $lts {
        $location = 'http://pkg.jenkins-ci.org/debian-stable'
      } else {
        $location = 'http://pkg.jenkins-ci.org/debian'
      }
      
      apt::source { 'jenkins':
        location    => $location,
        release     => 'binary/',
        repos       => '',
        key         => 'D50582E6',
        key_source  => 'http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key',
        include_src => false,
      }
    }
    RedHat: {
      if $lts {
        $location = 'http://pkg.jenkins-ci.org/redhat-stable/'
      } else {
        $location = 'http://pkg.jenkins-ci.org/redhat/'
      }

      yumrepo {'jenkins':
        descr    => 'Jenkins',
        baseurl  => $location,
        gpgcheck => 1,
        gpgkey   => "http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key"
      }
    }
    default: {
      fail( "Unsupported OS family: ${::osfamily}" )
    }
  }
}