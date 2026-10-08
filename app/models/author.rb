class Author < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  filterrific(
    default_filter_params: {},
    available_filters: [:search_query]
  )

  scope :search_query, ->(query) {
    return all if query.blank?
    where("LOWER(name) LIKE ?", "%#{query.to_s.downcase}%")
  }

  def self.options_for_select
    order(:name).map { |author| [author.name, author.id] }
  end
end