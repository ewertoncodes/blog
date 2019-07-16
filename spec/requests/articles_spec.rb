require 'rails_helper'

RSpec.describe 'Articles API', type: :request do
  let!(:articles) { create_list(:article, 10) }

  describe 'GET /articles' do
    before { get '/articles' }

    it "returns status ok" do
      expect(response).to have_http_status(:ok)
    end

    it "returns a list of articles" do
      expect(JSON.parse(response.body).size).to eq(10)
    end 
  end

  describe 'POST /articles' do
    context 'with valid attributes' do
      it "returns status created" do
        post '/articles', params: { title:"title-1", text: "hello world" }
        expect(response).to have_http_status(:created)
      end

      it "creates a article" do
        expect{
          post '/articles', params: { title:"title-1", text: "hello world" }
        }.to change(Article, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it "returns status unprocessable_entity" do
        post '/articles', params: { title:"title-1" }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "does not create article" do
        expect{
          post '/articles', params: { title:"title-1", text: nil }
        }.to_not change(Article, :count)
      end
    end
  end
end