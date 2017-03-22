# == Schema Information
#
# Table name: usuarios
#
#  id                   :integer          not null, primary key
#  primer_apellido      :string
#  segundo_apellido     :string
#  nombres              :string
#  tipo_de_documento_id :integer
#  numero_documento     :string
#  fecha_expedicion     :date
#  role_type              :integer
#  uid                  :string
#  valido               :boolean
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  document_photo_id    :integer
#  email                :string
#  password_hash        :string
#  password_salt        :string
#

class Usuario < ApplicationRecord
  attr_accessor :password, :password_confirmation

  belongs_to :tipo_de_documento, required: !:admin?
  belongs_to  :document_photo
  before_save :encrypt_password_for_admin

  has_many  :causes
  has_many  :polls,  dependent: :destroy
  has_many  :voted_polls, source: 'poll', through: 'votes', foreign_key: 'poll_id'
  has_many  :votes, dependent: :destroy
  has_many  :debate_votes, dependent: :destroy

  validates  :primer_apellido, :format => { :with => /\A[a-zA-Z\sÁÉÍÓÚÄËÏÖÜÀÈÌÒÙÑáéíóúäëïöüñàèìòùæ.-]+\z/}
  validates  :segundo_apellido, :format => { :with => /\A[a-zA-Z\sÁÉÍÓÚÄËÏÖÜÀÈÌÒÙÑáéíóúäëïöüñàèìòù.-]+\z/}
  validates  :nombres, :format => { :with => /\A[a-zA-Z\sÁÉÍÓÚÄËÏÖÜÀÈÌÒÙÑáéíóúäëïöüñàèìòù.-]+\z/}
  validates  :document_photo_id, presence: true
  validates_presence_of  [:primer_apellido, :segundo_apellido, :nombres]
  validates :uid, uniqueness: true
  validate :fecha_de_expedicion_razonable, unless: :admin?

  validate :validar_cedula, unless: :admin?
  validate :email_for_admin, if: :admin?
  validate :password_for_admin, on: :create, if: :admin?
  validate :password_for_admin_update, on: :update, if: :admin?
  validates :numero_documento, numericality: { only_integer: true }, uniqueness: true, unless: :admin?
  validates :tipo_de_documento, presence: true, unless: :admin?
  validates :uid, presence: true, unless: :admin?
  validates :numero_documento, presence: true,  unless: :admin?

  enum role_type: [:ciudadano, :politico, :administrador]
  def already_voted?(poll)
    !(votes.find_by(poll: poll).nil?)
  end

  def debate_already_voted?(debate)
    !(debate_votes.find_by(debate: debate).nil?)
  end

  def full_name
    "#{nombres} #{primer_apellido} #{segundo_apellido}"
  end

  def self.get_admin(params)
    user = find_by_email(params[:email])
    if user && user.password_hash == BCrypt::Engine.hash_secret( params[:password], user.password_salt)
      user
    else
      nil
    end
  end

  private

    def encrypt_password_for_admin
      if password.present? && (role_type == "administrador")
        self.password_salt = BCrypt::Engine.generate_salt
        self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
      end
    end

    def fecha_de_expedicion_razonable
      if fecha_expedicion.blank? || (fecha_expedicion > Date.today)
        errors.add(:fecha_expedicion, I18n.t(:fecha_invalida))
      end
    end

    def password_for_admin
      if (password.nil? || password.present? != password_confirmation.present?)
        errors.add(:contraseña, I18n.t(:password))
      end
    end

    def password_for_admin_update
      if (self.password != self.password_confirmation)
        errors.add(:contraseña, I18n.t(:password))
      end
    end

    def email_for_admin
      if email.nil?
        errors.add(:email, I18n.t(:email))
      end
    end

    def validar_cedula
      if !(/^\d+$/.match(numero_documento)) || Coldocument.find_by(doc_num: numero_documento.to_i).nil?
        errors.add(:numero_documento, I18n.t(:cedula_invalida))
      end
    end

    def admin?
      role_type == "administrador"
    end

end
