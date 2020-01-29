if @result.success?
  json.user do
    json.partial! 'users/user', user: @result.user
  end
else
  json.errors @result.errors
end
