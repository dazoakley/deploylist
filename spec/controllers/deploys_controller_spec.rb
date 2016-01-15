require 'rails_helper'

describe DeploysController do
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
      deploy = FactoryGirl.create(:deploy)
      story  = FactoryGirl.create(:story, deploy: deploy, title: 'My Story Title')

      get :index
      expect(response.body).to include('My Story Title')
    end
  end

  describe 'create_comment' do
    context 'with a body' do
      it 'creates a comment' do
        get :index
        # expect()
      end
    end

    context 'without a body' do
      it 'does not create a comment'
    end
  end
end
