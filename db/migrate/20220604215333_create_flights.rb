class CreateFlights < ActiveRecord::Migration[7.0]
  def change
    create_table :flights do |t|
      t.string :code
      t.datetime :date
      t.integer :arrival_id
      t.integer :departure_id

      t.timestamps
    end
  end
end
