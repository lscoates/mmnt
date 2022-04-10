class RemoveNotNullFromMomentBody < ActiveRecord::Migration[7.0]
  def change
    change_column_null :moments, :body, true
  end
end
