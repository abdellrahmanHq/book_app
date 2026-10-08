require 'csv'

class Book < ApplicationRecord
  belongs_to :author

  validates :name, presence: true, uniqueness: { case_sensitive: false, message: "already exists in the library" }
  validate :release_date_cannot_be_in_the_future

filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :search_query,
      :with_author_id,
      :with_release_date,
      :sorted_by
    ]
  )

  scope :search_query, ->(query) {
    return nil if query.blank?
    joins(:author).where("books.name ILIKE :q OR authors.name ILIKE :q", q: "%#{query}%")
  }

  scope :with_author_id, ->(author_id) {
    return nil if author_id.blank?
    where(author_id: author_id)
  }

  scope :with_release_date, ->(date) {
    return nil if date.blank?
    where(release_date: date)
  }

  scope :sorted_by, ->(sort_option) {
    direction = sort_option.match?(/desc$/) ? 'desc' : 'asc'
    
    case sort_option.to_s
    when /^created_at_/
      order("books.created_at #{direction}")
    when /^release_date_/
      order("books.release_date #{direction}")
    else
      raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  }

  
def self.to_csv
    headers = ['Book Name', 'Release Date', 'Author Name']
    CSV.generate(headers: true) do |csv|
      csv << headers
      all.each do |book|
        csv << [book.name, book.release_date, book.author.name]
      end
    end
  end

  private

  def release_date_cannot_be_in_the_future
    if release_date.present? && release_date > Date.today
      errors.add(:release_date, "can't be in the future")
    end
  end
end