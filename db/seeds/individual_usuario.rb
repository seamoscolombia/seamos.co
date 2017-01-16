coldoc = Coldocument.last
new_coldoc = Coldocument.create!(doc_num: coldoc.doc_num + 1,divipol_id: coldoc.divipol_id + 1)

document_photo = DocumentPhoto.create!(:url => "/uploads/document_photo/url/25/photo.png")

usuario_last = Usuario.last
Usuario.create!(
  primer_apellido: "firstSurname",
  segundo_apellido: "secondSurname",
  nombres: "Names",
  tipo_de_documento_id: 1,
  numero_documento: new_coldoc.doc_num,
  fecha_expedicion: "2011-05-28",
  role_id: 1,
  uid: (usuario_last.uid.to_i + 1).to_s,
  valido: false,
  document_photo_id: document_photo.id
)
