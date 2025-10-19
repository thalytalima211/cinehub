class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :rating
      t.references :movie, null: false, foreign_key: true
      t.references :user, null: true, foreign_key: true
      t.string :username

      t.timestamps
    end
  end
end
