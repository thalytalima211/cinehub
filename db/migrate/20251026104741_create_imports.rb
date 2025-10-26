class CreateImports < ActiveRecord::Migration[7.1]
  def change
    create_table :imports do |t|
      t.string :file
      t.string :status
      t.text :error_message

      t.timestamps
    end
  end
end
