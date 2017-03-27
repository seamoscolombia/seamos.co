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
      let(:pre_invalid_record) { FactoryGirl.create(:usuario, uid: Usuario.last.uid + rand(30), numero_documento: 'abc') }
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

  describe 'Usuario#full_name' do
    let(:user) { FactoryGirl.build(:usuario, nombres: 'John', primer_apellido: 'Dummy', segundo_apellido: 'Doe') }
    context 'when usuario has nombres, primer_apellido y segundo_apellido' do
      it 'returns usuario full name' do
        expect(user.full_name).to eq('John Dummy Doe')
      end
    end
  end

  describe 'Usuario#already_voted?' do
    let(:user) { FactoryGirl.create(:usuario) }
    let(:voted_poll) { FactoryGirl.create(:poll_with_votes) }
    let(:non_voted_poll) { FactoryGirl.create(:poll) }
    context 'when usuario has already voted for a poll' do
      it 'returns true' do
        # voted_poll.votes.first.usuario = user
        user.votes << voted_poll.votes.first
        expect(user.already_voted?(voted_poll)).to be true
      end
    end
    context 'when usuario has not voted for a poll' do
      it 'returns false' do
        expect(user.already_voted?(non_voted_poll)).to be false
      end
    end
  end

  describe 'Usuario.get_admin()' do
    let(:admin_user) { FactoryGirl.create(:usuario, role_type: 2) }
    let(:non_admin_user) { FactoryGirl.create(:usuario, role_type: 0) }
    context 'when usuario is an admin' do
      it 'returns the usuario' do
        params =  { email: admin_user.email, password: admin_user.password }
        expect(Usuario.get_admin(params)).to eq(admin_user)
      end
    end
    context 'when usuario is not an admin' do
      it 'returns nil' do
        params =  { email: non_admin_user.email, password: non_admin_user.password }
        expect(Usuario.get_admin(params)).to eq(nil)
      end
    end
  end
end
