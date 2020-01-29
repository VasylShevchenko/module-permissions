class API < Grape::API
  prefix 'api'
  format :json
  default_format :json
  formatter :json, Grape::Formatter::Jbuilder
  content_type :json, 'application/json'


  before do
    header['X-Frame-Options'] = 'SAMEORIGIN'
    header['X-Content-Type-Options'] = 'nosniff'
    # header 'X-Base-Header', 'will be defined for all APIs that are mounted below'
    # header['Access-Control-Allow-Origin'] = '*'
    # header['Access-Control-Request-Method'] = '*'
  end


  rescue_from ActiveRecord::RecordNotFound do |exception|
    show_error!(exception, 404)
  end

  rescue_from Grape::Exceptions::ValidationErrors do |exception|
    @errors = {}
    exception.as_json.each do |e|
      @errors[e[:params].first.to_s] = e[:messages]
    end
    error!({ errors: @errors }, 400)
  end

  rescue_from :all do
    show_error!('Internal server error', 500)
  end if Rails.env.production?

  helpers CommonHelpers
  helpers UserPermissionHelpers

  mount V1::Base

end
