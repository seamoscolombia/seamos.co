
json.extract! @usuario,
              :id, :primer_apellido, :segundo_apellido,
              :nombres, :tipo_de_documento_id, :numero_documento,
              :fecha_expedicion,:uid
json.authenticity_token form_authenticity_token
