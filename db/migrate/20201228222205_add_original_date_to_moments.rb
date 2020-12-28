class AddOriginalDateToMoments < ActiveRecord::Migration[6.0]
  def change
    add_column :moments, :original_date, :datetime
  end
end
