# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TweetsController, type: :controller do
  render_views

  describe '#create' do
    let(:tweet) { Tweet.new(content: '🚲👸🎁', user_id: 1) }
    let(:params) do
      { tweet: { content: '🚲👸🎁' , user_id: 1 }}
    end

    context 'when ok' do
      before do
        allow(Tweet).to receive(:new).and_return(tweet)
        allow(tweet).to receive(:save).and_return(true)

        post :create, params: params
      end
      it 'returns HTTP status created' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when ko' do
      before do
        allow(Tweet).to receive(:new).and_return(tweet)
        allow(tweet).to receive(:save).and_return(false)

        post :create, params: params
      end

      it 'return unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe '#update' do
    let(:params) do
      { id: 1, tweet: { content: '🚲👸🎁' , user_id: 1 }}
    end
    let(:tweet) { Tweet.new(id: 1, content: '🚲👸🎁', user_id: 1) }

    context 'when ok' do
      before do
        allow(Tweet).to receive(:find).and_return(tweet)
        allow(tweet).to receive(:update).and_return(true)

        get :update, params: params
      end
      it 'returns HTTP status ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when ko' do
      before do
        allow(Tweet).to receive(:find).and_return(tweet)
        allow(tweet).to receive(:update).and_return(false)

        post :create, params: params
      end

      it 'return unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe '#update' do
    let(:params) do
      { id: 1 }
    end
    let(:tweet) { Tweet.new(id: 1, content: '🚲👸🎁', user_id: 1) }

    before do
      allow(Tweet).to receive(:find).and_return(tweet)
      allow(tweet).to receive(:destroy).and_return(true)

      delete :destroy, params: params
    end
    it 'returns HTTP status no content' do
      expect(response).to have_http_status(:no_content)
    end
  end
end