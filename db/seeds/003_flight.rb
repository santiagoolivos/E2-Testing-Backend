# frozen_string_literal: true

Flight.find_or_create_by(code: 'SCL-LIM',
                         departure: Airport.find_by(city: 'Santiago'),
                         arrival: Airport.find_by(city: 'Lima'),
                         date: '2020-01-01')
Flight.find_or_create_by(code: 'LIM-SCL',
                         departure: Airport.find_by(city: 'Lima'),
                         arrival: Airport.find_by(city: 'Santiago'),
                         date: '2020-01-01')
Flight.find_or_create_by(code: 'NY-LIM',
                         departure: Airport.find_by(city: 'New York'),
                         arrival: Airport.find_by(city: 'Lima'),
                         date: '2022-07-02')
Flight.find_or_create_by(code: 'CHG-HST',
                         departure: Airport.find_by(city: 'Chicago'),
                         arrival: Airport.find_by(city: 'Houston'),

                         date: '2022-07-02')
Flight.find_or_create_by(code: 'LA-CHG',
                         departure: Airport.find_by(city: 'Los Angeles'),
                         arrival: Airport.find_by(city: 'Chicago'),
                         date: '2022-07-09')
Flight.find_or_create_by(code: 'LA2-CHG',
                          departure: Airport.find_by(city: 'Los Angeles'),
                          arrival: Airport.find_by(city: 'Chicago'),
                          date: '2022-07-09')
