# == Schema Information
#
# Table name: users
#
#  id                                        :integer          not null, primary key
#  first_surname                             :string
#  second_surname                            :string
#  names                                     :string
#  document_number                           :string
#  expedition_date                           :date
#  uid                                       :string
#  approved                                  :boolean
#  created_at                                :datetime         not null
#  updated_at                                :datetime         not null
#  email                                     :string
#  password_hash                             :string
#  password_salt                             :string
#  role_type                                 :integer
#  admin_photo                               :string
#  organization                              :string
#  bio                                       :string
#  birthday                                  :date
#  birthplace                                :string
#  profession                                :string
#  university                                :string
#  further_studies                           :text
#  last_election_vote_count                  :integer
#  represented_organizations                 :text
#  major_electoral_representation_localities :string
#  other_periods_elected                     :string
#  current_corporation_commission            :integer
#  proposed_initiatives_to_date              :text
#  twitter_username                          :string
#

class User < ApplicationRecord
  mount_uploader :admin_photo, AdminPhotoUploader

  attr_accessor :password, :password_confirmation

  before_save :encrypt_password_for_admin

  has_many  :causes
  has_many  :polls,  dependent: :destroy
  has_many  :voted_polls, source: 'poll', through: 'votes', foreign_key: 'poll_id'
  has_many  :votes, dependent: :destroy
  has_many  :debate_votes, dependent: :destroy
  has_many :interests, dependent: :destroy
  has_many :tags, -> { distinct }, through: :interests

  has_many :academic_titles, inverse_of: :user, dependent: :destroy
  accepts_nested_attributes_for :academic_titles, reject_if: proc { |attributes| attributes[:title].blank? }, allow_destroy: true

  validates  :first_surname, :format => { :with => /\A[a-zA-Z\sÁÉÍÓÚÄËÏÖÜÀÈÌÒÙÑáéíóúäëïöüñàèìòùæ.-]+\z/}
  # validates  :second_surname, :format => { :with => /\A[a-zA-Z\sÁÉÍÓÚÄËÏÖÜÀÈÌÒÙÑáéíóúäëïöüñàèìòù.-]+\z/}
  validates  :names, :format => { :with => /\A[a-zA-Z\sÁÉÍÓÚÄËÏÖÜÀÈÌÒÙÑáéíóúäëïöüñàèìòù.-]+\z/}
  validates  :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/}, if: :admin?
  validates_presence_of  [:first_surname, :names, :role_type]
  validates_presence_of  [:bio, :organization, :admin_photo], if: :politician?
  validates :uid, uniqueness: true, unless: [:admin?, :politician?]

  validate :email_for_admin, if: :admin?
  validate :password_for_admin, on: :create, if: :admin?
  validate :password_for_admin_update, on: :update, if: :admin?
  validate :major_electoral_representation_localities_length, if: :politician?
  validates :uid, presence: true, unless: [:admin?, :politician?]

  enum role_type: {ciudadano: 0, politico: 1, administrador: 2}
  enum current_corporation_commission: {"Comisión del plan": 0, "Comisión de Gobierno": 1, "Comisión de Hacienda": 2}
  enum localitie: { "Usaquén": 0,
                  "Chapinero": 1,
                  "Santa Fe": 2,
                  "San Cristóbal": 3,
                  "Usme": 4,
                  "Tunjuelito":5,
                  "Bosa": 6,
                  "Kennedy": 7,
                  "Fontibón": 8,
                  "Engativá": 9,
                  "Suba": 10,
                  "Barrios Unidos": 11,
                  "Teusaquillo": 12,
                  "Los Mártires": 13,
                  "Antonio Nariño": 14,
                  "Puente Aranda": 15,
                  "La Candelaria": 16,
                  "Rafael Uribe Uribe": 17,
                  "Ciudad Bolívar": 18,
                  "Sumapaz": 19,
                  }

  scope :by_role_type, -> (role_type) {
    where(role_type: role_type)
  }

  scope :search, -> (search_term) {
    where("names ILIKE ? OR first_surname ILIKE ? OR second_surname ILIKE ? OR email ILIKE ?", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%")
  }

  def already_voted?(poll)
    !(votes.find_by(poll: poll).nil?)
  end

  def full_name
    "#{names} #{first_surname} #{second_surname}"
  end

  def vote_count
    votes.size
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

    def major_electoral_representation_localities_length
      if self.major_electoral_representation_localities.split(',').length > 2
        errors.add(:major_electoral_representation_localities, "Seleccione sólo dos de las localidades de mayor representación electoral")
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

    def politician?
      role_type == "politico"
    end

    def admin?
      role_type == "administrador"
    end

end
