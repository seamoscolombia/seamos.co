json.array!(@tipo_de_documentos) do |tipo_de_documento|
  json.extract! tipo_de_documento, :id, :code_view
  json.url tipo_de_documentos_url(tipo_de_documento, format: :json)
end
