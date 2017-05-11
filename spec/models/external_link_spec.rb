# == Schema Information
#
# Table name: external_links
#
#  id         :integer          not null, primary key
#  url        :string
#  poll_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe ExternalLink, type: :model do
    # describe 'relations' do
    #   it { should belong_to(:poll) }
    # end

    describe 'validations' do
      let(:poll) { FactoryGirl.create(:poll) }
      context 'custom' do
        let(:external_link) { FactoryGirl.create(:external_link) }
        it 'url field has invalid URL' do
          external_link.url = 'not a url'
          byebug
          external_link.poll = poll
          external_link.valid?
          expect(external_link.errors[:url]).to include('es inválido')
        end
       
        it 'url field has valid URL' do
          external_link.poll = poll
          expect(external_link.valid?).to be true
        end
      end
    end
    context 'predeterminates' do
      let(:external_link) { FactoryGirl.create(:external_link) }
      it 'user reference field is invalid' do
        external_link.poll = nil
        external_link.valid?
        expect(external_link.errors[:user]).to include('User es requerido')
      end
    end
end
