if @roles.save
  json.roles do
    json.name @roles.name
    json.permissions @roles.permissions
  end
else
  json.errors @roles.errors.messages
end






