module UserPermissionHelpers

  def user_auth_by_token!
    auth_token = AuthToken.find_by_token(params[:token])
    auth_token&.user
  end

  def current_user
    @current_user ||= user_auth_by_token!
  end

  def authenticate!
    show_error!('Unauthorized, token', 401) unless current_user
    show_error!('Unauthorized, blocked user', 401) unless current_user_permissions.active
  end

  def permissions(permission, message)
    authenticate!
    show_error!("#{message}", 401) unless current_user_permissions[permission]
  end

  def current_user_permissions
    OpenStruct.new(current_user.get_full_list_permissions)
  end

  def show_error!(message, code)
    error!({ errors: { error: [message] } }, code)
  end

  def show_error_params!(params, message, code)
    error!({ errors: { "#{params.to_sym}": [message] } }, code)
  end
end
