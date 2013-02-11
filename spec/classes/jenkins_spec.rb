require 'spec_helper'

describe 'jenkins' do
  let(:facts) { { :osfamily => 'Debian' } }

  it { should contain_class('jenkins::repository') }
  it { should contain_package('jenkins') }

  it do
    should contain_service('jenkins').with(
      'ensure'     => 'running',
      'enable'     => true,
      'hasstatus'  => true,
      'hasrestart' => true,
    )
  end
end