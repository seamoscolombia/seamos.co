require 'test_helper'

class TipoDeDocumentosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tipo_de_documentos_index_url
    assert_response :success
  end

end
