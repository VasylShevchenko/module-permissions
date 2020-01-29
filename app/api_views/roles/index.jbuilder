json.roles do
  json.array! @roles do |role|
    json.name role.name
    json.permissions role.permissions
  end
end


