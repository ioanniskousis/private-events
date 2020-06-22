class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.text :description, null: false
      t.datetime :event_date, null: false
      t.string :location, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :events, :event_date
  end
end
