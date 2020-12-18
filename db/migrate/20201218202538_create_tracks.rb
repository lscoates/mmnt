class CreateTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :tracks do |t|
      t.string :name, null: false
      t.references :user, index: true, null: false
      t.timestamps null: false
    end
  end
end
