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
#  email                :string
#  password_hash        :string
#  password_salt        :string
#

require 'test_helper'

class UsuarioTest < ActiveSupport::TestCase

  def setup
    @usuario = Usuario.new(primer_apellido: "primer apellido", segundo_apellido: "segundo apellido",
                     nombres: "nombres", tipo_de_documento: tipo_de_documentos(:one),
                     numero_documento: "1113645899", fecha_expedicion: 1.day.ago,
                     role: roles(:one), uid: "cualquierCosa"
    )
  end

  test 'fecha de expedición debe ser <= hoy' do
    @usuario.fecha_expedicion = 1.day.from_now
    assert_not @usuario.valid?
  end

  test 'usuario valido' do
    assert @usuario.valid?
  end

  test "usuario debe tener primer apellido" do
    @usuario.primer_apellido = nil
    assert_not @usuario.valid?
  end

  test "usuario debe tener segundo apellido" do
    @usuario.segundo_apellido = nil
    assert_not @usuario.valid?
  end

  test "numero de documento no puede tener caracteres" do
    @usuario.numero_documento = "123ndk"
    assert_not @usuario.valid?
  end

  test "numero de documento valido" do
    @usuario.numero_documento = "123"
    assert @usuario.valid?
  end
end
