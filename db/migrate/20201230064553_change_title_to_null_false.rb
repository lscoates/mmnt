class ChangeTitleToNullFalse < ActiveRecord::Migration[6.0]
  def change
    change_column :moments, :title, :string, null: false
  end
end
