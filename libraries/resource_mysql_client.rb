require 'chef/resource/lwrp_base'
require_relative 'helpers'

extend Opscode::Mysql::Helpers
#
class Chef
  class Resource
    class MysqlClient < Chef::Resource
      extend Opscode::Mysql::Helpers
      # Initialize resource
      def initialize(name = nil, run_context = nil)
        super
        @resource_name = :mysql_client
        @service_name = name

        @allowed_actions = [:create, :delete]
        @action = :create

        # set default values
        @version = default_version_for(
          node['platform'],
          node['platform_family'],
          node['platform_version']
          )
      end

      # attribute :version, kind_of: String
      def version(arg = nil)
        @version = arg
      end

    end
  end
end
