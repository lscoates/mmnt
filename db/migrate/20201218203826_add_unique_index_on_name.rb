class AddUniqueIndexOnName < ActiveRecord::Migration[6.0]
  def change
    add_index :tracks, [:user_id, :name], unique: true
  end
end
