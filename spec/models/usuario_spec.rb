require 'rails_helper'

RSpec.describe Usuario, type: :model do
  describe 'relations' do
    it { should have_many(:causes) }
    it { should have_many(:polls) }
    it { should have_many(:voted_polls) }
    it { should have_many(:votes) }
    it { should have_many(:debate_votes) }
    it { should belong_to(:tipo_de_documento) }
    it { should belong_to(:document_photo) }
  end

  describe 'enums' do
    it { should define_enum_for(:role_type) }
  end

  describe 'validations' do
    describe 'not an admin validations' do
      let(:empty_record) { Usuario.new(role_type: 0, uid: '', numero_documento: '') }
      it 'should validate presence' do
        empty_record.valid?
        expect(empty_record.errors[:uid]).to include('no puede estar en blanco')
        expect(empty_record.errors[:numero_documento]).to include('no puede estar en blanco')
        expect(empty_record.errors[:tipo_de_documento]).to include('no puede estar en blanco')
      end
      let(:pre_invalid_record) { FactoryGirl.create(:usuario, uid: '1', numero_documento: 'abc') }
      let(:invalid_record) { Usuario.new(role_type: 0, uid: '1', numero_documento: 'abc') }
      it 'should validate numericality' do
        invalid_record.valid?
        expect(invalid_record.errors[:numero_documento]).to include('no es un número')
      end
      it 'should validate uniqueness' do
        invalid_record.valid?
        expect(invalid_record.errors[:uid]).to include('ya ha sido tomado')
        expect(invalid_record.errors[:numero_documento]).to include('ya ha sido tomado')
      end
    end
    it { should validate_presence_of(:primer_apellido) }
    it { should validate_presence_of(:segundo_apellido) }
    it { should validate_presence_of(:nombres) }
    it { should validate_presence_of(:role_type) }
    it { should validate_presence_of(:document_photo_id) }

    describe '#primer_apellido' do
      it { should_not allow_value('surname123').for(:primer_apellido) }
    end
    describe '#segundo_apellido' do
      it { should_not allow_value('surname123').for(:segundo_apellido) }
    end
    describe '#nombres' do
      it { should_not allow_value('name123').for(:segundo_apellido) }
    end
  end
end
