# frozen_string_literal: true

5.times do |flight|
  9.times do |row|
    Seat.find_or_create_by(flight_id: flight, used: false, seat_code: "A#{row + 1}")
    Seat.find_or_create_by(flight_id: flight, used: false, seat_code: "B#{row + 1}")
    Seat.find_or_create_by(flight_id: flight, used: false, seat_code: "C#{row + 1}")
    Seat.find_or_create_by(flight_id: flight, used: false, seat_code: "D#{row + 1}")
  end
  Seat.find_or_create_by(user_id: 2, flight_id: flight, used: true, seat_code: 'A10', passenger_name: 'Benja')
  Seat.find_or_create_by(user_id: 3, flight_id: flight, used: true, seat_code: 'B10', passenger_name: 'Juan')
  Seat.find_or_create_by(user_id: 4, flight_id: flight, used: true, seat_code: 'C10', passenger_name: 'Pedro')
  Seat.find_or_create_by(user_id: 5, flight_id: flight, used: true, seat_code: 'D10', passenger_name: 'Santiago')
end
