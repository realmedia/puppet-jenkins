# Define: jenkins::plugin
#
#
define jenkins::plugin (
  $version     = 0,
  $jenkins_url = 'http://localhost:8080'
) {
  
  if ($version != 0) {
    $plugin_url = "http://updates.jenkins-ci.org/download/plugins/${name}/${version}/${name}.hpi"
  } else {
    $plugin_url = $name
  }
  
  exec { "jenkins-plugin-${name}-download-cli":
    command => "wget -O /tmp/jenkins-cli.jar ${jenkins_url}/jnlpJars/jenkins-cli.jar",
    creates => "/tmp/jenkins-cli.jar",
    timeout => 0,
  }

  exec { "jenkins-plugin-${name}-install":
    command => "java -jar /tmp/jenkins-cli.jar -s ${jenkins_url} install-plugin ${plugin_url} -deploy",
    timeout => 0,
    require => Exec["jenkins-plugin-${name}-download-cli"],
  }
}