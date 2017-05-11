json.array!(@users) do |user|
  json.extract! user, :id, :first_surname, :segundo_apellido, :nombres, :tipo_de_documento_id, :numero_documento, :fecha_expedicion, :rol_id, :nombre_user, :password_digest, :valido
  json.url users_url(user, format: :json)
end
