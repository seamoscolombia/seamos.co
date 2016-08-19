require 'test_helper'

class UsuariosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @usuario = usuarios(:one)
  end

  test "should get index" do
    get usuarios_url
    assert_response :success
  end

  test "should get new" do
    get new_usuario_url
    assert_response :success
  end

  # test "should create usuario" do
  #    assert_difference('Usuario.count') do
  #      post usuarios_url, params: { usuario: { uid:  @usuario.uid ,fecha_expedicion: @usuario.fecha_expedicion,  nombres: @usuario.nombres, numero_documento: @usuario.numero_documento,  primer_apellido: @usuario.primer_apellido, rol_id: @usuario.rol_id, segundo_apellido: @usuario.segundo_apellido, tipo_de_documento_id: @usuario.tipo_de_documento_id, valido: @usuario.valido } }
  #    end
  #
  #   assert_redirected_to usuario_url(Usuario.last)
  # end

  test "should show usuario" do
    get usuario_url(@usuario)
    assert_response :success
  end

  test "should get edit" do
    get edit_usuario_url(@usuario)
    assert_response :success
  end


  test "should destroy usuario" do
    assert_difference('Usuario.count', -1) do
      delete usuario_url(@usuario)
    end

    assert_redirected_to usuarios_url
  end
end
