require 'rails_helper'

RSpec.describe Admin::PollsController, type: :controller do
  let(:admin) { FactoryGirl.create(:user, role_type: 2)}
  let(:politician) { FactoryGirl.create(:user, role_type: 1)}
  describe 'GET index' do
    before do
      @open_and_non_voted_polls = []
      @closed_polls = []
      @own_polls = []
      @other_polls = []
    end
    context 'when user is admin' do
      it 'assigns all polls to @polls' do
        sign_in admin
        2.times { @open_and_non_voted_polls << FactoryGirl.create(:poll) }
        2.times { @closed_polls << FactoryGirl.create(:poll, closing_date: Date.today - 3.days) }
        get :index
        expect(assigns(:polls)).to match_array(Poll.all)
      end
    end
    context 'when user is politician' do
      it 'assigns only politician own polls to @polls' do
        sign_in politician
        2.times { @own_polls << FactoryGirl.create(:poll, user: politician) }
        2.times { @other_polls << FactoryGirl.create(:poll, closing_date: Date.today - 3.days) }
        get :index
        expect(assigns(:polls)).to match_array(@own_polls)
      end
    end

    it 'renders the index template' do
      sign_in admin
      get :index
      expect(response).to render_template('index')
    end

    it 'should return status ok' do
      sign_in admin
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET edit' do
    context 'when the user is not an admin' do
      let(:poll) { FactoryGirl.create(:poll) }
      it 'redirects to root path' do
        get :edit, params: {id: poll.id}
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when the user is a politician' do
      let(:poll) { FactoryGirl.create(:poll) }
      it 'renders the edit template' do
        sign_in politician
        get :edit, params: {id: poll.id}
        expect(response).to render_template('edit')
      end

      it 'responds with ok http status' do
        sign_in politician
        get :edit, params: {id: poll.id}
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the user is an admin' do
      let(:poll) { FactoryGirl.create(:poll) }
      it 'redirects to root path' do
        sign_in admin
        get :edit, params: {id: poll.id}
        expect(response).to have_http_status(302)
      end
    end

    context 'when the user is not logged in' do
      let(:poll) { FactoryGirl.create(:poll) }
      it 'redirects to root path' do
        sign_in admin
        get :edit, params: {id: poll.id}
        expect(response).to have_http_status(302)
      end
    end
  end
end
