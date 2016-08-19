require 'test_helper'

class IniciarSesionTest < ActionDispatch::IntegrationTest

  def setup
    @auth_hash = {:uid => '12345', :info => {:name => 'Joe', :email => 'joe@example.com'}}
    OmniAuth.config.add_mock(:facebook, @auth_hash)
  end

  test "inicio sesion en FB" do
    get root_path
    get "/auth/facebook/callback"
    assert false
    # assert_select 'field'
  end

end
