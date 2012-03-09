require 'fog/core/collection'
require 'fog/openstack/models/identity/user'

module Fog
  module Identity
    class OpenStack
      class Users < Fog::Collection
        model Fog::Identity::OpenStack::User

        def all
          load(connection.list_users.body['users'])
        end

        def find_by_id(id)
          self.find {|user| user.id == id} ||
            Fog::Identity::OpenStack::User.new(
              connection.get_user_by_id(id).body['user'])
        end

        def destroy(id)
          user = self.find_by_id(id)
          user.destroy
        end
      end # class Users
    end # class OpenStack
  end # module Identity
end # module Fog
