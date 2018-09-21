# == Schema Information
#
# Table name: external_links
#
#  id              :integer          not null, primary key
#  url             :string
#  poll_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  is_project_link :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe ExternalLink, type: :model do
  describe 'relations' do
    it { should belong_to(:poll) }
  end

  describe 'validations' do
    context 'when creating external link with an invalid url' do
      let(:external_link) { FactoryGirl.build(:external_link) }
      it 'returns invalid url field error' do
        external_link.url = 'not an url'
        external_link.valid?
        expect(external_link.errors[:url]).to include('es inválido')
      end
      it 'has valid URL' do
        expect(external_link.valid?).to be true
      end
    end
  end
  context 'when creating external without poll id' do
    let(:external_link) { FactoryGirl.create(:external_link) }
    it 'return poll reference field invalid' do
      external_link.poll = nil
      external_link.valid?
      expect(external_link.errors[:poll]).to include('Propuesta es requerido')
    end
  end
end
