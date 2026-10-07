require 'rails_helper'

RSpec.describe Book, type: :model do
  it "requires a unique name" do
    create(:book, name: "mybook")
    duplicate_book = build(:book, name: "mybook")
    
    expect(duplicate_book).not_to be_valid
  end

  it "is invalid if the release date is in the future" do
    book = build(:book, release_date: Date.tomorrow)
    
    expect(book).not_to be_valid
    expect(book.errors[:release_date]).to include("can't be in the future")
  end
end