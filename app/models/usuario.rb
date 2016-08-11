class Usuario < ApplicationRecord
  belongs_to :tipo_de_documento
  belongs_to :rol
  has_secure_password
  validates :nombre_usuario, presence: true, length: { minimum: 10, maximum: 120}
end
