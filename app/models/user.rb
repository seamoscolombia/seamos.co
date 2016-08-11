class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  belongs_to :tipo_de_documento
  belongs_to :rol
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
