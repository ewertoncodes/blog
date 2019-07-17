require 'rails_helper'

RSpec.describe 'Comments Api' do
  let(:article_id) { create(:article).id }
  let!(:comments) { create_list(:comment, 10, article_id: article_id) }
  let(:comment_id) { comments.first.id }

  describe 'GET /articles/:articles_id/comments' do
    it 'returns status ok' do
      get "/articles/#{article_id}/comments"
      
      expect(response).to have_http_status(:ok)
    end

    it 'returns a list of comment' do
      get "/articles/#{article_id}/comments"
      
      expect(JSON.parse(response.body).size).to eq(10)
    end
  end

  describe 'POST /articles/:articles_id/comments' do
    it 'does something' do
      post "/articles/#{article_id}/comments", params: { body: "cool post!" }

      expect(response).to have_http_status(:created)
    end

    it 'does something' do
      expect{
        post "/articles/#{article_id}/comments", params: { body: "cool post!" }
      }.to change(Comment,:count).by(1)
    end
  end

  describe 'PUT /articles/:articles_id/comments/:id' do
    it 'returns no_content' do
      put "/articles/#{article_id}/comments/#{comment_id}", params: { body: "muito bom" }

      expect(response).to have_http_status(:no_content)
    end

    it 'updates the attributes' do
      put "/articles/#{article_id}/comments/#{comment_id}", params: { body: "muito bom" }
      
      comment = comments.first
      comment.reload
      expect(comment.body).to eq('muito bom')
    end
  end

  describe 'DETE /articles/:articles_id/comments/:id' do
    it 'returns status no content' do
      delete "/articles/#{article_id}/comments/#{comment_id}"

      expect(response).to have_http_status(:no_content)
    end

    it 'destroys the article' do
      expect{  delete "/articles/#{article_id}/comments/#{comment_id}" }.to change(Comment, :count).by(-1)
    end
  end
end