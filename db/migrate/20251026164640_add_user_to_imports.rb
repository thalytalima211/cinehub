class AddUserToImports < ActiveRecord::Migration[7.1]
  def change
    add_reference :imports, :user, null: false, foreign_key: true
  end
end
