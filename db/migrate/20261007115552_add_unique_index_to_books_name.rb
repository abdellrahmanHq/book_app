class AddUniqueIndexToBooksName < ActiveRecord::Migration[8.1]
  def change
    add_index :books, :name, unique: true
  end
end
