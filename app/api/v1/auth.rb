class V1::Auth < Grape::API
  namespace :auth do

    desc 'User Sign up'
    params do
      requires :user, type: Hash do
        requires :email,    allow_blank: false, type: String
        requires :password, allow_blank: false, type: String
      end
    end
    post 'signup', jbuilder: 'auth/signup' do
      @result = Auth::RegisterUser.call(params: clean_params, request: request)
      status @result.code
    end

    desc 'Simple authorization'
    params do
      requires :user, type: Hash do
        requires :email, allow_blank: false, type: String
        requires :password, allow_blank: false, type: String
      end
    end
    post 'signin', jbuilder: 'auth/signin' do


      @result = Auth::SigninUser.call(params: clean_params, request: request)
      status @result.code
    end

  end
end
