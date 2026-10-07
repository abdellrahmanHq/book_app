require 'csv'

class Book < ApplicationRecord
  belongs_to :author
  validates :name, presence: true, uniqueness: { case_sensitive: false, message: "already exists in the library" }

  validate :release_date_cannot_be_in_the_future

  filterrific(
    default_filter_params: { sorted_by: 'release_date_desc' },
    available_filters: [
      :search_query,
      :with_author_id,
      :sorted_by
    ]
  )

  scope :search_query, ->(query) {
    return nil if query.blank?
    where("LOWER(name) LIKE ?", "%#{query.downcase}%")
  }

  scope :with_author_id, ->(author_id) {
    where(author_id: author_id)
  }

  scope :sorted_by, ->(sort_key) {
    case sort_key.to_s
    when 'release_date_desc'
      order(release_date: :desc)
    when 'release_date_asc'
      order(release_date: :asc)
    when 'created_at_desc'
      order(created_at: :desc)
    else
      order(release_date: :desc)
    end
  }

  def self.to_csv
    attributes = %w[id name release_date author_id created_at]
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |book|
        csv << attributes.map { |attr| book.send(attr) }
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