coldoc = Coldocument.last
new_coldoc = Coldocument.create!(doc_num: coldoc.doc_num + 1,divipol_id: coldoc.divipol_id + 1)

document_photo = DocumentPhoto.create!(:url => "/uploads/document_photo/url/25/photo.png")

usuario_last = User.last
usuario = User.create!(
  first_surname: "firstSurname",
  segundo_apellido: "secondSurname",
  nombres: "Names",
  tipo_de_documento_id: 1,
  numero_documento: new_coldoc.doc_num,
  fecha_expedicion: "2011-05-28",
  role_id: 1,
  uid: (usuario_last.uid.to_i + 1).to_s,
  approved: false,
  document_photo_id: document_photo.id
)

poll_last = Poll.last
vote_type = poll_last.vote_types.first

if poll_last.private?
  totals = eval(@poll.totals)
  totals[vote_type.id] += 1
  poll_last.totals = totals
  poll_last.save!
  vote = usuario.votes.build( poll_id: @poll.id )
else
  vote = usuario.votes.build(
      poll_id: poll_last.id,
      vote_type: vote_type
  )
end
