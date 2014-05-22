
case node['platform']
when 'rhel'
  default['yum']['ius']['enabled'] = true
end
