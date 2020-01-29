if @result.success?
  json.user do
    json.partial! 'users/auth', user: @result.user, auth_token: false
  end
else
  json.errors @result.errors
end
