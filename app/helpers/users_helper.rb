module UsersHelper
  def get_photo_url(user)
    return DocumentPhoto.find_by(id: user.document_photo_id).url
  end
end
