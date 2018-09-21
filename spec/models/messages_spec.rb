# == Schema Information
#
# Table name: interests
#
#  id         :integer          not null, primary key
#  tag_id     :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Message do
  describe 'validations' do
    let(:invalid_message) do
      Message.new(
        sender: 'invalidemail', 
        receivers: "receiver1@receiver.com", 
        subject: "dummy subject", 
        content: "dummy content", 
        user_name: "john doe Jr", 
      )
    end
    let(:valid_message) do
      Message.new(
        sender: 'validemail@service.com', 
        receivers: "receiver1@receiver.com", 
        subject: "dummy subject", 
        content: "dummy content", 
        user_name: "john doe Jr", 
      )
    end
    context 'when creating external link with an invalid url' do
      context 'when sender email has an invalid format' do
        it 'is not valid' do
          invalid_message.valid?
          expect(invalid_message.errors[:sender]).to include('es inválido')
        end
      end
      context 'when sender email has a valid format' do
        it 'is valid' do
          expect(valid_message.valid?).to be true
        end
      end
    end
  end

  describe '#persisted?' do
    let(:valid_message) do
      Message.new(
        sender: 'validemail@service.com', 
        receivers: "receiver1@receiver.com", 
        subject: "dummy subject", 
        content: "dummy content", 
        user_name: "john doe Jr", 
      )
    end
    it 'is not persisted' do
      expect(valid_message.persisted?).to be(false)
    end
  end
end
