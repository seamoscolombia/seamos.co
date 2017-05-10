json.array!(@usuarios) do |usuario|
  json.extract! usuario, :id, :first_surname, :segundo_apellido, :nombres, :tipo_de_documento_id, :numero_documento, :fecha_expedicion, :rol_id, :nombre_usuario, :password_digest, :valido
  json.url usuarios_url(usuario, format: :json)
end
