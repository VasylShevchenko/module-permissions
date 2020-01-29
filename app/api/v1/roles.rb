class V1::Roles < Grape::API
  namespace :roles do

    desc 'Get all roles'
    params do
      requires :token, type: String, allow_blank: false
    end
    get '', jbuilder: 'roles/index' do
      authenticate!
      @roles = Role.all
    end

    desc 'Create role'
    params do
      requires :token,       type: String, allow_blank: false
      requires :name,        type: String, allow_blank: false
      requires :permissions, type: Hash do
        PERMISSIONS.each_key { |k| optional k, type: Boolean, allow_blank: true }
      end
    end
    post 'create', jbuilder: 'roles/create' do
      authenticate!

      params_role = clean_params.permit(:name, permissions: [PERMISSIONS.keys])
      @roles = Role.new(params_role)
    end

    desc 'Assign the role to a user.'
    params do
      requires :token,       type: String, allow_blank: false
      requires :name,        type: String, allow_blank: false
      requires :user_id,     type: Integer, allow_blank: false
    end
    post 'assign-user' do
      authenticate!

      user = User.find params[:user_id]

      role = Role.find_by_name params[:name]
      show_error!("Role not found", 404) if role.blank?

      user.permissions = role.permissions
      user.role = role
      user.save

      status :ok
      { result: "success" }
    end

  end
end
