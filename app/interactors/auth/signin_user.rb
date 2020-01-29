module Auth
  class SigninUser
    include Interactor

    def call
      context.user = User.find_for_authentication(email: email)

      error_unauthorized! unless context.user

      error_unauthorized! unless context.user.valid_password?(password)

      context.user.update_tracked_fields!(request)
    end

    private

    def user_params
      context.params.require(:user).permit(:email, :password)
    end

    def email
      user_params[:email].downcase
    end

    def password
      user_params[:password]
    end

    def request
      context.request
    end

    def error_unauthorized!
      context.fail! errors: { error: ['email or password is wrong'] }, code: :unauthorized
    end
  end
end
