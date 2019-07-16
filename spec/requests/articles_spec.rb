require 'rails_helper'

RSpec.describe 'Articles API', type: :request do
  let!(:articles) { create_list(:article, 10) }
  let(:article_id) { articles.first.id }

  describe 'GET /articles' do
    it "returns status ok" do
      get '/articles'

      expect(response).to have_http_status(:ok)
    end

    it "returns a list of articles" do
      get '/articles'

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

  describe 'GET /articles/:id' do
    context 'when the article exists' do
      it "returns status ok" do
        get "/articles/#{article_id}"
       
        expect(response).to have_http_status(:ok)
      end

      it 'returns the article' do
        get "/articles/#{article_id}"
        
        expect(JSON.parse(response.body)['id']).to eq(article_id)        
      end
    end

    context 'when the article does not exist' do
      let(:article_id) { 1000 }
      
      it "returns status ok" do
        get "/articles/#{article_id}"
       
        expect(response).to have_http_status(:not_found)
      end

      it 'returns the article' do
        get "/articles/#{article_id}"

        expect(response.body).to match(/Couldn't find Article/)    
      end
    end
  end

  describe 'PATCH /articles/:id' do
    context "ok" do
      let(:article) { articles.first }
      
      it 'returns status ok' do
        
        patch "/articles/#{article_id}", params: { title:"title-1", text: "olá mundo" }
        
        expect(response).to have_http_status(:no_content)
      end

      it 'updates the attributes' do
        patch "/articles/#{article_id}", params: { title:"title-1", text: "olá mundo" }
        
        article.reload
        
        expect(article.text).to eq('olá mundo')
      end
    end 
  end

  describe 'PUT /articles/:id' do
    let(:article) { articles.first }
    
    it 'returns status ok' do
      put "/articles/#{article_id}", params: { title:"title-1", text: "olá mundo" }
      
      expect(response).to have_http_status(:no_content)
    end

    it 'updates the attributes' do
      put "/articles/#{article_id}", params: { title:"title-1", text: "olá mundo" }
      
      article.reload
      
      expect(article.text).to eq('olá mundo')
    end
  end

  describe 'DELETE /articles/:id' do
    it 'returns status no content' do
      delete "/articles/#{article_id}"

      expect(response).to have_http_status(:no_content)
    end

    it 'destroys the article' do
      expect{delete "/articles/#{article_id}"}.to change(Article, :count).by(-1)
    end
  end
end