require 'rails_helper'

RSpec.describe 'Articles API', type: :request do
  let(:user){ create(:user)}
  let!(:articles) { create_list(:article, 10, user_id: user.id) }
  let(:article_id) { articles.first.id }
  let(:headers) { valid_headers }

  describe 'GET /articles' do
    it "returns status ok" do
      get '/articles', headers: headers
      expect(response).to have_http_status(:ok)
    end

    it "returns a list of articles" do
      get '/articles', headers: headers
      
      expect(JSON.parse(response.body).size).to eq(10)
    end 
  end

  describe 'POST /articles' do
    let(:valid_attributes) do
      { title:"title-1", text: "hello world", user_id: user.id }.to_json
    end

    context 'with valid attributes' do
      it "returns status created" do
        post '/articles', params: valid_attributes , headers: headers
        expect(response).to have_http_status(:created)
      end

      it "creates a article" do
        expect{
          post '/articles', params: valid_attributes, headers: headers
        }.to change(Article, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { { title: nil }.to_json }
      it "returns status unprocessable_entity" do
        post '/articles', params: invalid_attributes, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "does not create article" do
        expect{
          post '/articles', params: invalid_attributes, headers: headers
        }.to_not change(Article, :count)
      end
    end
  end

  describe 'GET /articles/:id' do
    context 'when the article exists' do
      it "returns status ok" do
        get "/articles/#{article_id}", headers: headers
       
        expect(response).to have_http_status(:ok)
      end

      it 'returns the article' do
        get "/articles/#{article_id}", headers: headers
        
        expect(JSON.parse(response.body)['id']).to eq(article_id)        
      end
    end

    context 'when the article does not exist' do
      let(:article_id) { 1000 }
      
      it "returns status ok" do
        get "/articles/#{article_id}", headers: headers
       
        expect(response).to have_http_status(:not_found)
      end

      it 'returns the article' do
        get "/articles/#{article_id}", headers: headers

        expect(response.body).to match(/Couldn't find Article/)    
      end
    end
  end

  describe 'PATCH /articles/:id' do
    context "ok" do
      let(:article) { articles.first }
      let(:valid_attributes) do
        { title:"title-1", text: "olá mundo" }.to_json
      end
      
      it 'returns status no_contentk' do
        patch "/articles/#{article_id}", params: valid_attributes, headers: headers
        
        expect(response).to have_http_status(:no_content)
      end

      it 'updates the attributes' do
        patch "/articles/#{article_id}", params: valid_attributes, headers: headers

        article.reload
        
        expect(article.text).to eq('olá mundo')
      end
    end 
  end

  describe 'PUT /articles/:id' do
    let(:article) { articles.first }
    let(:valid_attributes) do
      { title:"title-1", text: "olá mundo" }.to_json
    end

    it 'returns status ok' do
      put "/articles/#{article_id}", params: valid_attributes, headers: headers
      
      expect(response).to have_http_status(:no_content)
    end

    it 'updates the attributes' do
      put "/articles/#{article_id}", params: valid_attributes, headers: headers
      
      article.reload
      
      expect(article.text).to eq('olá mundo')
    end
  end

  describe 'DELETE /articles/:id' do
    it 'returns status no content' do
      delete "/articles/#{article_id}", headers: headers

      expect(response).to have_http_status(:no_content)
    end

    it 'destroys the article' do
      expect{delete "/articles/#{article_id}", headers: headers}.to change(Article, :count).by(-1)
    end
  end
end