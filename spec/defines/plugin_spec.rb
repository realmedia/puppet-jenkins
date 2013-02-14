require 'spec_helper'

describe 'jenkins::plugin' do
  let(:title) { 'foo' }
  let(:facts) { { :osfamily => 'Debian', :operatingsystem => 'Ubuntu' } }

  context "with default jenkins_url param" do
    it do
      should contain_exec('jenkins-plugin-foo-download-cli').with(
        'command' => 'wget -O /tmp/jenkins-cli.jar http://localhost:8080/jnlpJars/jenkins-cli.jar',
        'creates' => '/tmp/jenkins-cli.jar',
        'timeout' => 0,
      )
    end

    it do
      should contain_exec('jenkins-plugin-foo-install').with(
        'command' => 'java -jar /tmp/jenkins-cli.jar -s http://localhost:8080 install-plugin foo -deploy',
        'timeout' => 0,
        'require' => 'Exec[jenkins-plugin-foo-download-cli]',
      )
    end
  end

  context "with custom jenkins_url param" do
    let(:params) { { :jenkins_url => 'http://localhost:4949' } }

    it do
      should contain_exec('jenkins-plugin-foo-download-cli').with(
        'command' => 'wget -O /tmp/jenkins-cli.jar http://localhost:4949/jnlpJars/jenkins-cli.jar',
        'creates' => '/tmp/jenkins-cli.jar',
        'timeout' => 0,
      )
    end

    it do
      should contain_exec('jenkins-plugin-foo-install').with(
        'command' => 'java -jar /tmp/jenkins-cli.jar -s http://localhost:4949 install-plugin foo -deploy',
        'timeout' => 0,
        'require' => 'Exec[jenkins-plugin-foo-download-cli]',
      )
    end
  end
end