# == Schema Information
#
# Table name: document_photos
#
#  id         :integer          not null, primary key
#  url        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DocumentPhoto < ApplicationRecord
  mount_base64_uploader :url, FotoUploader
end
