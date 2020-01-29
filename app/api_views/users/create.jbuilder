if @result.success?
  json.partial! 'users/user', user: @result.user || @user
else
  json.errors   @result.errors
end
