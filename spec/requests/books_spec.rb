require 'rails_helper'

RSpec.describe "BooksControllers", type: :request do
  let(:abd) { create(:author) }
  let(:qusai) { create(:author) }
  let!(:book) { create(:book, author: abd) }

  describe "GET /books" do
    it "redirects to login when logged out" do
      get books_path
      expect(response).to redirect_to(new_author_session_path)
    end

    it "succeeds when logged in" do
      sign_in abd
      get books_path
      expect(response).to have_http_status(:success)
    end

    it "downloads CSV format successfully" do
      sign_in abd
      get books_path(format: :csv)
      
      expect(response).to have_http_status(:success)
      expect(response.media_type).to eq("text/csv")
    end
  end

  describe "POST /books" do
    it "creates a book assigned to the logged-in author" do
      sign_in abd
      
      expect {
        post books_path, params: { book: { name: "testbook", release_date: "2000-08-08" } }
      }.to change(Book, :count).by(1)
      
      expect(Book.last.author).to eq(abd)
      expect(response).to redirect_to(books_path)
    end
  end

  describe "DELETE /books/:id" do
    it "allows the owner to delete their book" do
      sign_in abd
      
      expect {
        delete book_path(book)
      }.to change(Book, :count).by(-1)
    end

    it "prevents an author from deleting someone else's book" do
      sign_in qusai
      
      expect {
        delete book_path(book)
      }.not_to change(Book, :count)
      
      expect(flash[:alert]).to eq("You Only Modify Your Own Books!")
    end
  end
end