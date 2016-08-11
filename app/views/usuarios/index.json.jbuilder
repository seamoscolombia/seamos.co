json.array!(@usuarios) do |usuario|
  json.extract! usuario, :id, :primer_apellido, :segundo_apellido, :nombres, :tipo_de_documento_id, :numero_documento, :fecha_expedicion, :rol_id, :nombre_usuario, :password_digest, :valido
  json.url usuario_url(usuario, format: :json)
end
