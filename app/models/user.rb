# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  first_surname        :string
#  second_surname       :string
#  names                :string
#  tipo_de_documento_id :integer
#  document_number      :string
#  expedition_date      :date
#  uid                  :string
#  approved             :boolean
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

  before_save :encrypt_password_for_admin

  has_many  :causes
  has_many  :polls,  dependent: :destroy
  has_many  :voted_polls, source: 'poll', through: 'votes', foreign_key: 'poll_id'
  has_many  :votes, dependent: :destroy
  has_many  :debate_votes, dependent: :destroy

  validates  :first_surname, :format => { :with => /\A[a-zA-Z\sÁÉÍÓÚÄËÏÖÜÀÈÌÒÙÑáéíóúäëïöüñàèìòùæ.-]+\z/}
  validates  :second_surname, :format => { :with => /\A[a-zA-Z\sÁÉÍÓÚÄËÏÖÜÀÈÌÒÙÑáéíóúäëïöüñàèìòù.-]+\z/}
  validates  :names, :format => { :with => /\A[a-zA-Z\sÁÉÍÓÚÄËÏÖÜÀÈÌÒÙÑáéíóúäëïöüñàèìòù.-]+\z/}
  validates  :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/}, if: :admin?
  validates_presence_of  [:first_surname, :second_surname, :names, :role_type]
  validates :uid, uniqueness: true, unless: :admin?

  validate :email_for_admin, if: :admin?
  validate :password_for_admin, on: :create, if: :admin?
  validate :password_for_admin_update, on: :update, if: :admin?
  validates :uid, presence: true, unless: :admin?

  enum role_type: {ciudadano: 0, politico: 1, administrador: 2}

  def already_voted?(poll)
    !(votes.find_by(poll: poll).nil?)
  end

  def debate_already_voted?(debate)
    !(debate_votes.find_by(debate: debate).nil?)
  end

  def full_name
    "#{names} #{first_surname} #{second_surname}"
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

    def admin?
      role_type != "ciudadano"
    end

end
