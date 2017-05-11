require 'rails_helper'

RSpec.describe ExternalLink, type: :model do

    describe 'validations' do
      context 'custom' do
        let(:external_link) { FactoryGirl.create(:external_link) }
        it 'url field has invalid URL' do
          external_link.url = 'not a url'
          external_link.valid?
          expect(external_link.errors[:url]).to include('es inválido')
        end
       
        it 'url field has valid URL' do
          expect(external_link.valid?).to be true
        end
      end
    end
end
