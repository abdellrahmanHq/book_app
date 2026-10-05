class Book < ApplicationRecord
  belongs_to :author
  
  validates :name, presence: true, uniqueness: true
  validates :release_date, presence: true
  validate :cannot_be_future
  private
  def cannot_be_future
    if release_date.present? && release_date > Date.today
      error.add(:release_date,"cannote be in the futuer")
    end
  end
end
