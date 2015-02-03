#
# Unit tests for designate::central
#
require 'spec_helper'

describe 'designate::central' do
  let :params do
    {
      :enabled => true
    }
  end

  shared_examples 'designate-central' do
    context 'with default parameters' do
      it 'installs designate-central package and service' do
        should contain_service('designate-central').with(
          :name      => platform_params[:central_service_name],
          :ensure    => 'running',
          :enable    => 'true'
        )
        should contain_package('designate-central').with(
          :name      => platform_params[:central_package_name],
          :ensure    => 'installed'
        )
      end

      it 'configures designate-central with default parameters' do
        should contain_designate_config('service:central/backend_driver').with_value('bind9')
      end

      context 'when using Power DNS backend driver' do
        before { params.merge!(:backend_driver => 'powerdns') }
        it 'configures designate-central with pdns backend' do
          should contain_designate_config('service:central/backend_driver').with_value('powerdns')
        end
      end
    end
  end

  context 'on Debian platforms' do
    let :facts do
      { :osfamily => 'Debian' }
    end

    let :platform_params do
      {
        :central_package_name => 'designate-central',
        :central_service_name => 'designate-central'
      }
    end

    it_configures 'designate-central'
  end

  context 'on RedHat platforms' do
    let :facts do
      { :osfamily => 'RedHat' }
    end

    let :platform_params do
      {
        :central_package_name => 'openstack-designate-central',
        :central_service_name => 'openstack-designate-central'
      }
    end

    it_configures 'designate-central'
  end
end