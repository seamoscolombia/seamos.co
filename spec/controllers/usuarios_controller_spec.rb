require 'rails_helper'
include SessionsHelper

RSpec.describe UsuariosController, type: :controller do
  describe 'GET index' do
    context 'when the request format is HTML' do
      it 'get usuarios' do
        5.times { FactoryGirl.create(:usuario) }
        get :index
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe 'POST create' do
    context 'request as json' do
     let(:tipo_de_documento) { FactoryGirl.create(:tipo_de_documento) }
     let(:coldocument) { FactoryGirl.create(:coldocument) }
      it 'An citizen usuario is created' do
          session[:uid] = rand(300).to_s
          post :create, params: { usuario: {
              primer_apellido:  Faker::Name.last_name,
              segundo_apellido: Faker::Name.last_name,
              nombres: Faker::Name.first_name,
              tipo_de_documento_id: tipo_de_documento.id,
              numero_documento: coldocument.doc_num,
              document_photo: 'docphoto',
              fecha_expedicion: Date.today - 1000.days,
              email: Faker::Internet.email,
              role_type: 0
            }
          }, format: :json
          expect(response).to have_http_status(:created)
      end
    end
  end
end
