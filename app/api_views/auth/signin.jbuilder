if @result.success?
  json.user do
    json.partial! 'users/auth', user: @result.user, auth_token: true
  end
else
  json.errors @result.errors
end
