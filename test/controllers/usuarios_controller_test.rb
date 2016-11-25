require 'test_helper'

class UsuariosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @usuario = usuarios(:one)
  end

  test "should get non-valid 'usuarios'" do
    init_session_json("uidString3","fb_token")
    get usuarios_url

    assert_select 'h1', 'Usuarios'
    assert_select 'li', count: 2
  end


  test "should create usuario with format_json" do
    init_session_json("uid","fb_token")
    assert_difference('Usuario.count') do
       post usuarios_url, params: {
          photo_id: document_photos(:one).id,
          usuario: {
            fecha_expedicion: @usuario.fecha_expedicion,
            nombres: "three", numero_documento: 1_113_645_711.to_s,
            primer_apellido: "third surname",
            segundo_apellido: "third second surname",
            tipo_de_documento_id: tipo_de_documentos(:one).id
         } }, as: :json
    end
    assert_response :created
  end

  # test "should create usuario for web" do
  #   post sessions_url, env: { 'omniauth.auth' => init_omniAuth() }, as:
  #   assert_difference('Usuario.count') do
  #      post usuarios_url, params: {
  #         photo_id: document_photos(:one).id,
  #         usuario: {
  #           fecha_expedicion: @usuario.fecha_expedicion,
  #           nombres: "three", numero_documento: 1_113_645_710.to_s,
  #           primer_apellido: "third surname",
  #           segundo_apellido: "third second surname",
  #           tipo_de_documento_id: tipo_de_documentos(:one).id
  #        } }
  #   end
  #   assert_response :created
  # end


  test "should get edit" do
    init_session_json("uidString3","fb_token")
    get edit_usuario_url(usuarios(:three))
    assert_select 'th', count: 5
    assert_select 'td', text: usuarios(:three).numero_documento, count: 1
    assert_response :success
  end

  test "validating usuario" do
    init_session_json("uidString3","fb_token")
    put usuario_url(usuarios(:one).id)
    assert_equal Usuario.where(valido: false).count, 1
    # assert_redirected_to usuarios_url
  end


  # test "should destroy usuario" do
  #   assert_difference('Usuario.count', -1) do
  #     delete usuario_url(@usuario)
  #   end
  #
  #   assert_redirected_to usuarios_url
  # end
end
