# json.email          user.email
json.token                      user.user_token
json.partial! 'users/verified', user: user
json.partial! 'users/email',    user: user
json.partial! 'users/user',     user: user
