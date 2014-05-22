require 'chef/provider/lwrp_base'

class Chef
  class Provider
    class MysqlClient
      class Rhel < Chef::Provider::MysqlClient
        use_inline_resources if defined?(use_inline_resources)

        def whyrun_supported?
          true
        end

        action :create do
          case node['platform_version'].to_i.to_s
          when '2013'
            case new_resource.version
            when '5.1'
              package_name = 'mysql'
            when '5.5'
              package_name = 'mysql'
            end
          when '2014'
            case new_resource.version
            when '5.1'
              package_name = 'mysql-server'
            when '5.5'
              package_name = 'mysql'
            end
          when '6'
            case new_resource.version
            when '5.1'
              package_name = 'mysql'
            when '5.5'
              package_name = 'mysql55'
            end
          when '5'
            case new_resource.version
            when '5.0'
              package_name = 'mysql'
            when '5.1'
              package_name = 'mysql51'
            when '5.5'
              package_name = 'mysql55'
            end
          end

          converge_by 'rhel pattern' do
            package_name = 'mysql55'
            [package_name, "#{package_name}-devel"].each do |p|
              package p do
                action :install
              end
            end
          end
        end

        action :delete do
          case node['platform_version'].to_i.to_s
          when '2013'
            case new_resource.version
            when '5.1'
              package_name = 'mysql'
            when '5.5'
              package_name = 'mysql'
            end
          when '2014'
            case new_resource.version
            when '5.1'
              package_name = 'mysql-server'
            when '5.5'
              package_name = 'mysql'
            end
          when '6'
            case new_resource.version
            when '5.1'
              package_name = 'mysql'
            when '5.5'
              package_name = 'mysql55'
            end
          when '5'
            case new_resource.version
            when '5.0'
              package_name = 'mysql'
            when '5.1'
              package_name = 'mysql51'
            when '5.5'
              package_name = 'mysql55'
            end
          end
          converge_by 'rhel pattern' do
            package_name = 'mysql55'
            [package_name, "#{package_name}-devel"].each do |p|
              package p do
                action :remove
              end
            end
          end
        end
      end
    end
  end
end

Chef::Platform.set :platform => :rhel, :resource => :mysql_client, :provider => Chef::Provider::MysqlClient::Rhel
Chef::Platform.set :platform => :amazon, :resource => :mysql_client, :provider => Chef::Provider::MysqlClient::Rhel
Chef::Platform.set :platform => :redhat, :resource => :mysql_client, :provider => Chef::Provider::MysqlClient::Rhel
Chef::Platform.set :platform => :centos, :resource => :mysql_client, :provider => Chef::Provider::MysqlClient::Rhel
Chef::Platform.set :platform => :oracle, :resource => :mysql_client, :provider => Chef::Provider::MysqlClient::Rhel
Chef::Platform.set :platform => :scientific, :resource => :mysql_client, :provider => Chef::Provider::MysqlClient::Rhel
