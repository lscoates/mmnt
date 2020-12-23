class CreateMoments < ActiveRecord::Migration[6.0]
  def change
    create_table :moments do |t|
      t.text :body
      t.references :track, index: true, null: false
      t.timestamps null: false
    end
  end
end
