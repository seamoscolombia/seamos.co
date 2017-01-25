# == Schema Information
#
# Table name: usuarios
#
#  id                   :integer          not null, primary key
#  primer_apellido      :string
#  segundo_apellido     :string
#  nombres              :string
#  tipo_de_documento_id :integer
#  numero_documento     :string           not null
#  fecha_expedicion     :date
#  role_id              :integer
#  uid                  :string           not null
#  valido               :boolean
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  document_photo_id    :integer
#

class Usuario < ApplicationRecord
  belongs_to :tipo_de_documento
  belongs_to :role
  belongs_to  :document_photo

  has_many  :causes
  has_many  :polls
  has_many  :voted_polls, source: 'poll', through: 'votes', foreign_key: 'poll_id'
  has_many  :votes, dependent: :destroy
  has_many  :debate_votes, dependent: :destroy

  validates  :primer_apellido, :format => { :with => /\A[a-zA-Z\sÁÉÍÓÚÄËÏÖÜÀÈÌÒÙÑáéíóúäëïöüñàèìòùæ.-]+\z/}
  validates  :segundo_apellido, :format => { :with => /\A[a-zA-Z\sÁÉÍÓÚÄËÏÖÜÀÈÌÒÙÑáéíóúäëïöüñàèìòù.-]+\z/}
  validates  :nombres, :format => { :with => /\A[a-zA-Z\sÁÉÍÓÚÄËÏÖÜÀÈÌÒÙÑáéíóúäëïöüñàèìòù.-]+\z/}
  validates_presence_of  [:primer_apellido, :segundo_apellido,
     :nombres, :numero_documento, :document_photo_id]
  validates :numero_documento, numericality: { only_integer: true }, uniqueness: true
  validate :fecha_de_expedicion_razonable
  validate :validar_cedula


  def already_voted?(poll)
    !(votes.find_by(poll: poll).nil?)
  end

  def debate_already_voted?(debate)
    !(debate_votes.find_by(debate: debate).nil?)
  end

  def full_name
    "#{nombres} #{primer_apellido} #{segundo_apellido}"
  end

  private

    def fecha_de_expedicion_razonable
      if fecha_expedicion.blank? || (fecha_expedicion > Date.today)
        errors.add(:fecha_expedicion, I18n.t(:fecha_invalida))
      end
    end

    def validar_cedula

      if !(/^\d+$/.match(numero_documento)) || Coldocument.find_by(doc_num: numero_documento.to_i).nil?
        errors.add(:numero_documento, I18n.t(:cedula_invalida))
      end
    end

end
