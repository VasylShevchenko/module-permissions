module Auth
  class RegisterUser
    include Interactor

    def call
      check_email = User.find_by(email: params_email)
      context.fail! errors: {email: ['user already registered']}, code: 302 if check_email.present?

      context.user = User.new(user_params)
      context.user.update_tracked_fields(request)

      unless context.user.save!
        context.fail! errors: context.user.errors,
                      code: :unauthorized
      end
    end

    private

    def user_params
      context.params.require(:user).permit(:email, :password)
    end

    def request
      context.request
    end

    def params_email
      context.params['user']['email'].downcase
    end
  end
end
