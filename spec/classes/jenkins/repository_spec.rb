require 'spec_helper'

describe 'jenkins::repository' do

  context 'with lts => true' do
    let(:params) { { :lts => true } }

    context 'on Debian' do
      let(:facts) { { :osfamily => 'Debian' } }

      it do
        should contain_apt__source('jenkins').with(
          'location'    => 'http://pkg.jenkins-ci.org/debian-stable',
          'release'     => 'binary/',
          'repos'       => '',
          'key'         => 'D50582E6',
          'key_source'  => 'http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key',
          'include_src' => false,
        )
      end
    end

    context 'on Redhat' do
      let(:facts) { { :osfamily => 'Redhat' } }

      it do
        should contain_yumrepo('jenkins').with(
          'descr'    => 'Jenkins',
          'baseurl'  => 'http://pkg.jenkins-ci.org/redhat-stable/',
          'gpgcheck' => 1,
          'gpgkey'   => "http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key"
        )
      end
    end
  end

  context 'with lts => false' do
    let(:params) { { :lts => false } }

    context 'on Debian' do
      let(:facts) { { :osfamily => 'Debian' } }

      it do
        should contain_apt__source('jenkins').with(
          'location'    => 'http://pkg.jenkins-ci.org/debian',
          'release'     => 'binary/',
          'repos'       => '',
          'key'         => 'D50582E6',
          'key_source'  => 'http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key',
          'include_src' => false,
        )
      end
    end

    context 'on Redhat' do
      let(:facts) { { :osfamily => 'Redhat' } }

      it do
        should contain_yumrepo('jenkins').with(
          'descr'    => 'Jenkins',
          'baseurl'  => 'http://pkg.jenkins-ci.org/redhat/',
          'gpgcheck' => 1,
          'gpgkey'   => "http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key"
        )
      end
    end
  end  
end