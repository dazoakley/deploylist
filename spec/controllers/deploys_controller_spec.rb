require 'rails_helper'

describe DeploysController, type: :controller do
  describe "ping" do
    it 'is pong' do
      get :ping
      expect(response.body).to eq('pong')
    end
  end

  describe "deploy" do
    before do
      allow(FullImport).to receive(:call)
    end

    it 'kicks off an import' do
      get :deploy
      expect(FullImport).to have_received(:call).with(limit: 1, stream: response.stream)
    end

    it 'uses text/event-stream' do
      get :deploy
      expect(response.headers['Content-Type']).to eq('text/event-stream')
    end
  end

  describe 'index' do
    render_views

    it 'responds with a 200' do
      get :index
      expect(response).to be_success
    end

    it 'lists out existing deploys' do
      sign_in(FactoryGirl.create(:user))
      deploy = FactoryGirl.create(:deploy)
      story  = FactoryGirl.create(:story, deploy: deploy, title: 'My Story Title')

      get :index
      expect(response.body).to include('My Story Title')
    end
  end

  describe 'create_comment' do
    let(:user)   { FactoryGirl.create(:user) }
    let(:deploy) { FactoryGirl.create(:deploy) }

    before do
      sign_in(user)
    end

    it 'redirects to the "all deploys" route' do
      post :create_comment, id: deploy.id, comment: { body: 'Good Stuff', deploy_id: deploy.id, user_id: user.id }
      expect(response).to redirect_to(all_deploys_path)
    end

    context 'with a body' do
      it 'creates a comment' do
        expect {
          post :create_comment, id: deploy.id, comment: { body: 'Good Stuff', deploy_id: deploy.id, user_id: user.id }
        }.to change { Comment.count }.by(1)
      end
    end

    context 'without a body' do
      it 'does not create a comment' do
        post :create_comment, id: deploy.id, comment: { body: '', deploy_id: deploy.id, user_id: user.id }
        expect(Comment.count).to eq(0)
      end
    end
  end
end
