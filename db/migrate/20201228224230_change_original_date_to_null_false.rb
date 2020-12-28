class ChangeOriginalDateToNullFalse < ActiveRecord::Migration[6.0]
  def change
    change_column :moments, :original_date, :datetime, null: false
  end
end
