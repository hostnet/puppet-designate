Puppet::Type.newtype(:designate_api_uwsgi_config) do

  ensurable

  newparam(:name, :namevar => true) do
    desc 'Section/setting name to manage from /etc/designate/designate-api-uwsgi.ini'
    newvalues(/\S\/\S/)
  end

  newproperty(:value) do
    desc 'The value of the setting to be defined.'
    munge do |value|
      value = value.to_s.strip
      value.capitalize! if value =~ /^(true|false)$/i
      value
    end
    newvalues(/^[\S ]*$/)
  end

  newparam(:ensure_absent_val) do
    desc 'A value that is specified as the value property will behave as if ensure => absent was specified'
    defaultto('<SERVICE DEFAULT>')
  end

  autorequire(:anchor) do
    ['designate::install::end']
  end

end
