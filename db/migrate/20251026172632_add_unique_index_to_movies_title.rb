class AddUniqueIndexToMoviesTitle < ActiveRecord::Migration[7.1]
  def change
    add_index :movies, :title, unique: true
  end
end
