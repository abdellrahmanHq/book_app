class AddNameToAuthors < ActiveRecord::Migration[8.1]
  def change
    add_column :authors, :name, :string
    add_index :authors, :name, unique: true
  end
end
