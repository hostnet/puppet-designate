# == Class: designate::params
#
#  Parameters for puppet-designate
#
class designate::params {
  include openstacklib::defaults

  $state_path                = '/var/lib/designate'
  $log_dir                   = '/var/log/designate'
  $client_package_name       = 'python3-designateclient'
  $agent_service_name        = 'designate-agent'
  $api_service_name          = 'designate-api'
  $central_service_name      = 'designate-central'
  $sink_service_name         = 'designate-sink'
  $mdns_service_name         = 'designate-mdns'
  $producer_service_name     = 'designate-producer'
  $worker_service_name       = 'designate-worker'
  $group                     = 'designate'
  $user                      = 'designate'

  case $facts['os']['family'] {
    'RedHat': {
      # package name
      $common_package_name          = 'openstack-designate-common'
      $api_package_name             = 'openstack-designate-api'
      $central_package_name         = 'openstack-designate-central'
      $agent_package_name           = 'openstack-designate-agent'
      $sink_package_name            = 'openstack-designate-sink'
      $mdns_package_name            = 'openstack-designate-mdns'
      $producer_package_name        = 'openstack-designate-producer'
      $worker_package_name          = 'openstack-designate-worker'
      $designate_wsgi_script_path   = '/var/www/cgi-bin/designate'
      $designate_wsgi_script_source = '/usr/bin/designate-api-wsgi'
    }
    'Debian': {
      # package name
      $common_package_name          = 'designate-common'
      $api_package_name             = 'designate-api'
      $central_package_name         = 'designate-central'
      $agent_package_name           = 'designate-agent'
      $sink_package_name            = 'designate-sink'
      $mdns_package_name            = 'designate-mdns'
      $producer_package_name        = 'designate-producer'
      $worker_package_name          = 'designate-worker'
      $designate_wsgi_script_path   = '/usr/lib/cgi-bin/designate'
      $designate_wsgi_script_source = '/usr/bin/designate-api-wsgi'
    }
    default: {
      fail("Unsupported osfamily: ${facts['os']['family']}")
    }
  }
}
