class CreateSeats < ActiveRecord::Migration[7.0]
  def change
    create_table :seats do |t|
      t.integer :user_id
      t.integer :flight_id
      t.boolean :used
      t.string :passenger_name
      t.string :seat_code

      t.timestamps
    end
  end
end
