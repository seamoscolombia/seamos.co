class DocumentPhoto < ApplicationRecord
  mount_base64_uploader :url, FotoUploader
end
