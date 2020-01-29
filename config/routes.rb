Rails.application.routes.draw do
  devise_for :users
  mount API => '/'
  mount GrapeSwaggerRails::Engine => '/api/swagger'

  root to: redirect('/api/swagger')
end
