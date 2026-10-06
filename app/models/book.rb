class Book < ApplicationRecord
  belongs_to :author
  
  validates :name, presence: true, uniqueness: true
  validates :release_date, presence: true
  validate :cannot_be_future


  filterrific(
        default_filter_params: {sorted_by: "created_at_desc"},
        available_filters: [
            :search_query,
            :with_release_date,
            :with_author_id,
            :sorted_by
        ]
    )

    scope :sorted_by, ->(sort_option) {
    # Extract the sort direction from the param string.
    direction = sort_option =~ /desc$/ ? 'desc' : 'asc'
    
    case sort_option.to_s
    when /^created_at_/
      order("books.created_at #{direction}")
    when /^name_/ # Example: if you want to sort by book name
      order("books.name #{direction}")
    else
      raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  }

    scope :search_query, ->(query) {
        where("name ILIKE ?","%#{query}%")
    }

    scope :with_release_date, ->(date) {
        where(release_date: date)
    }

    scope :with_author_id, -> (author_id){
        where(author_id: author_id)
    }



    require 'csv'
    def self.to_csv
      attributes = %w[book_name release_date author_name] 
      CSV.generate(headers: true) do |csv|
        csv << attributes
        all.each do |book|
          csv << [book.name, book.release_date, book.author.name]
        end
      end
    end



  private
  def cannot_be_future
    if release_date.present? && release_date > Date.today
      error.add(:release_date,"cannote be in the futuer")
    end
  end
end
