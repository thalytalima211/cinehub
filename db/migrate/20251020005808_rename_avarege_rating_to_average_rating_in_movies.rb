class RenameAvaregeRatingToAverageRatingInMovies < ActiveRecord::Migration[7.1]
  def change
    rename_column :movies, :avarege_rating, :average_rating
  end
end
