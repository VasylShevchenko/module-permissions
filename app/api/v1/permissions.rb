class V1::Permissions < Grape::API
  namespace :permissions do

    desc 'Update permissions'
    params do
      requires :token, type: String, allow_blank: false
      requires :user_id,     type: Integer, allow_blank: false
      requires :permissions, type: Hash do
        PERMISSIONS.each_key { |k| optional k, type: Boolean, allow_blank: true }
      end
    end
    post ':user_id/update', jbuilder: 'permissions/permissions_update' do
      authenticate!

      user = User.find params[:user_id]

      @user_permissions = user.get_full_list_permissions
      params_permissions = clean_params.require(:permissions).permit(PERMISSIONS.keys)
      params_permissions.each_key { |k| @user_permissions[k] = params_permissions[k.to_s] }

      user.update(permissions: @user_permissions)
    end

  end
end
