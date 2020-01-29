json.present @role.present?

if @role.present?
  json.name        @role.name
  json.permissions @role.permissions
end
