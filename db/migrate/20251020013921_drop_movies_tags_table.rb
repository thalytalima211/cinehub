class DropMoviesTagsTable < ActiveRecord::Migration[7.1]
  def up
    drop_table :movies_tags
  end

  def down
    create_table :movies_tags, id: false do |t|
      t.bigint :movie_id, null: false
      t.bigint :tag_id, null: false
    end
  end
end
