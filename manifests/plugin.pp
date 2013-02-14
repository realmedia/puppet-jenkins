# Define: jenkins::plugin
#
#
define jenkins::plugin (
  $jenkins_url = 'http://localhost:8080'
) {
  
  exec { "jenkins-plugin-${name}-download-cli":
    command => "wget -O /tmp/jenkins-cli.jar ${jenkins_url}/jnlpJars/jenkins-cli.jar",
    creates => "/tmp/jenkins-cli.jar",
    timeout => 0,
  }

  exec { "jenkins-plugin-${name}-install":
    command => "java -jar /tmp/jenkins-cli.jar -s ${jenkins_url} install-plugin ${name} -deploy",
    timeout => 0,
    require => Exec["jenkins-plugin-${name}-download-cli"],
  }
}