class Author < ApplicationRecord
  has_many :books, dependent: :destroy
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, uniqueness: true

  def self.options_for_select
    order(:name).map{|author| [author.name, author.id]}
  end
end
