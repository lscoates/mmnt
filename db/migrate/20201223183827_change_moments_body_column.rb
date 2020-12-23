class ChangeMomentsBodyColumn < ActiveRecord::Migration[6.0]
  def change
    change_column :moments, :body, :text, null: false
  end
end
