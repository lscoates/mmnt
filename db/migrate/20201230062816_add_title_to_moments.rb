class AddTitleToMoments < ActiveRecord::Migration[6.0]
  def change
    add_column :moments, :title, :string
  end
end
