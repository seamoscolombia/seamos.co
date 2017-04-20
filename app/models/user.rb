# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  primer_apellido      :string
#  segundo_apellido     :string
#  nombres              :string
#  tipo_de_documento_id :integer
#  numero_documento     :string
#  fecha_expedicion     :date
#  uid                  :string
#  valido               :boolean
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  document_photo_id    :integer
#  email                :string
#  password_hash        :string
#  password_salt        :string
#  role_type            :integer
#

class User < ApplicationRecord
  attr_accessor :password, :password_confirmation

  belongs_to :tipo_de_documento, required: !:admin?
  belongs_to  :document_photo
  before_save :encrypt_password_for_admin

  has_many  :causes
  has_many  :polls,  dependent: :destroy
  has_many  :voted_polls, source: 'poll', through: 'votes', foreign_key: 'poll_id'
  has_many  :votes, dependent: :destroy
  has_many  :debate_votes, dependent: :destroy

  validates  :fst_surname, :format => { :with => /\A[a-zA-Z\sÁÉÍÓÚÄËÏÖÜÀÈÌÒÙÑáéíóúäëïöüñàèìòùæ.-]+\z/}
  validates  :snd_surname, :format => { :with => /\A[a-zA-Z\sÁÉÍÓÚÄËÏÖÜÀÈÌÒÙÑáéíóúäëïöüñàèìòù.-]+\z/}
  validates  :names, :format => { :with => /\A[a-zA-Z\sÁÉÍÓÚÄËÏÖÜÀÈÌÒÙÑáéíóúäëïöüñàèìòù.-]+\z/}
  validates  :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/}, if: :admin?
  validates  :document_photo_id, presence: true
  validates_presence_of  [:fst_surname, :snd_surname, :names, :role_type]
  validates :uid, uniqueness: true, unless: :admin? 
  validate :date_range_validation, unless: :admin? #Porque no se valida la fecha para el admin

  validate :document_validation, unless: :admin?
  validate :email_for_admin, if: :admin?
  validate :password_for_admin, on: :create, if: :admin?
  validate :password_for_admin_update, on: :update, if: :admin?
  validates :document_number, numericality: { only_integer: true }, uniqueness: true, unless: :admin?
  validates :tipo_de_documento, presence: true, unless: :admin?
  validates :uid, presence: true, unless: :admin?
  validates :document_number, presence: true,  unless: :admin?

  enum role_type: {ciudadano: 0, politico: 1, administrador: 2}

  def already_voted?(poll)
    !(votes.find_by(poll: poll).nil?)
  end

  def debate_already_voted?(debate)
    !(debate_votes.find_by(debate: debate).nil?)
  end

  def full_name
    "#{names} #{fst_surname} #{snd_surname}"
  end

  def self.get_admin(params)
    user = find_by_email(params[:email])
    if user && user.password_hash && user.password_hash == BCrypt::Engine.hash_secret( params[:password], user.password_salt)
      user
    else
      nil
    end
  end

  private

    def encrypt_password_for_admin
      if password.present? && (role_type != "ciudadano")
        self.password_salt = BCrypt::Engine.generate_salt
        self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
      end
    end

    def date_range_validation #Tambien validar que sea menor de 100 años
      if expedition_date.blank? || (expedition_date > Date.today) 
        errors.add(:expedition_date, I18n.t(:fecha_invalida))
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

    def document_validation
      if !(/^\d+$/.match(document_number)) || Coldocument.find_by(doc_num: document_number.to_i).nil?
        errors.add(:document_number, I18n.t(:cedula_invalida))
      end
    end

    def admin?
      role_type != "ciudadano"
    end

end
