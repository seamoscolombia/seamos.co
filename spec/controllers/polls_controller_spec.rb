require 'rails_helper'
include SessionsHelper

RSpec.describe PollsController, type: :controller do
  describe 'GET index' do
    let(:user) { FactoryGirl.create(:user, role_type: 0)}
    let(:closed_poll) { FactoryGirl.create(:poll, closing_date: Date.today - 3.days) }
    context 'when the request format is JSON' do
      it 'assigns open and non voted polls to @polls' do
        session[:email] = user.email
        voted_polls = []
        open_and_non_voted_polls = []
        closed_polls = []
        3.times { open_and_non_voted_polls << FactoryGirl.create(:poll) }
        3.times do
          poll = FactoryGirl.create(:poll)
          user.votes << FactoryGirl.create(:vote, poll: poll)
          voted_polls << poll
        end
        3.times { closed_polls << FactoryGirl.create(:poll, closing_date: Date.today - 3.days) }
        get :index, format: :json
        expect(assigns(:polls)).to match_array(open_and_non_voted_polls)
      end

      it 'does not assign closed polls to @polls' do
        open_polls = []
        3.times { open_polls << FactoryGirl.create(:poll) }
        get :index, format: :json
        expect(assigns(:polls)).not_to include(closed_poll)
      end

      it 'does not assign voted polls to @polls' do
        session[:email] = user.email
        voted_poll = FactoryGirl.create(:poll)
        user.votes << FactoryGirl.create(:vote, poll: voted_poll)
        open_polls = []
        3.times { open_polls << FactoryGirl.create(:poll) }
        get :index, format: :json
        expect(assigns(:polls)).not_to include(voted_poll)
      end
    end

    context 'when the request format is HTML' do
      it 'assigns @polls' do
        4.times { FactoryGirl.create(:poll) }
        all_polls = Poll.all
        get :index, format: :html
        expect(assigns(:polls)).to match_array(all_polls)
      end
    end

    describe "responds to" do
      it "responds to html by default" do
        get :index
        expect(response.content_type).to eq "text/html"
      end

      it "responds to custom formats when provided in the params" do
        get :index, format: :json
        expect(response.content_type).to eq "application/json"
      end
    end
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'should return status ok' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET show' do
    let(:poll) { FactoryGirl.create(:poll_with_votes)}
    context 'when the request format is JSON' do
      it 'assigns @poll' do
        get :show, params: { id: poll.id }, format: :json
        expect(assigns(:poll)).to eq(poll)
      end

      it 'renders the show template' do
        get :show, params: { id: poll.id }, format: :json
        expect(response).to render_template('show')
      end

      it 'should return status ok' do
        get :show, params: { id: poll.id }, format: :json
        expect(response).to have_http_status(:ok)
      end
    end

    describe "responds to" do
      it "responds to html by default" do
        get :show, params: { id: poll.id }
        expect(response.content_type).to eq "text/html"
      end

      it "responds to custom formats when provided in the params" do
        get :show, params: { id: poll.id }, format: :json
        expect(response.content_type).to eq "application/json"
      end
    end
  end

  describe 'GET filtered_by_tag' do
    context 'when the request format is JSON' do
      let(:user) { FactoryGirl.create(:user, role_type: 2) }
      let(:tag) { FactoryGirl.create(:tag) }
      it 'assigns @polls' do
        session[:email] = user.email
        @by_tag_polls = []
        3.times do
          poll = FactoryGirl.create(:poll)
          poll.tags << tag
          @by_tag_polls << poll
        end
        @other_polls = []
        3.times do
          poll = FactoryGirl.create(:poll)
          @other_polls << poll
        end
        get :filtered_by_tag, params: { tag_id: tag.id }, format: :json
        expect(assigns(:polls)).to match_array(@by_tag_polls)
      end
    end

    describe "responds to" do
      let(:tag) { FactoryGirl.create(:tag) }
      it "responds to JSON by default" do
        get :filtered_by_tag, params: { tag_id: tag.id }, format: :json
        expect(response.content_type).to eq "application/json"
      end
    end

    let(:tag) { FactoryGirl.create(:tag) }
    let(:user) { FactoryGirl.create(:user, role_type: 2) }
    it 'renders the filtered_by_tag template' do
      session[:email] = user.email
      get :filtered_by_tag, params: { tag_id: tag.id }, format: :json
      expect(response).to render_template('filtered_by_tag')
    end

    it 'should return status ok' do
      session[:email] = user.email
      get :filtered_by_tag, params: { tag_id: tag.id }, format: :json
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET edit' do
    context 'when the user is not an admin' do
      let(:poll) { FactoryGirl.create(:poll) }
      it 'assigns redirects to root path' do
        get :edit, params: {id: poll.id}
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when the user is an admin' do
      let(:poll) { FactoryGirl.create(:poll) }
      let(:user) { FactoryGirl.create(:user, role_type: 2)}
      it 'renders the edit template' do
        session[:email] = user.email
        get :edit, params: {id: poll.id}
        expect(response).to render_template(:edit)
      end
    end

    context 'when the poll is closed' do
      let(:poll) { FactoryGirl.create(:poll, closing_date: Date.today - 30.days) }
      let(:user) { FactoryGirl.create(:user, role_type: 2)}
      it 'renders the edit template' do
        session[:email] = user.email
        get :edit, params: {id: poll.id}
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
