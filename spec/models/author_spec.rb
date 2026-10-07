require 'rails_helper'

RSpec.describe Author, type: :model do
  it "requires a unique name" do
    create(:author, name: "author-abd")
    duplicate_author = build(:author, name: "author-abd")
    
    expect(duplicate_author).not_to be_valid
    expect(duplicate_author.errors[:name]).to include("has already been taken")
  end
end