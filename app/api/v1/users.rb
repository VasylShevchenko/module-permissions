class V1::Users < Grape::API
  namespace :users do

  desc 'Get full list permissions'
  params do
    requires :token, type: String, allow_blank: false
  end
  get 'permissions', jbuilder: 'users/permissions' do
    authenticate!
    @permissions = current_user.get_full_list_permissions
  end

  desc 'Get role'
  params do
    requires :token, type: String, allow_blank: false
  end
  get 'role', jbuilder: 'users/role' do
    authenticate!

    @role = current_user.role
    status :ok
  end

  end
end
