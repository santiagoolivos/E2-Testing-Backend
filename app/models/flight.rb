class Flight < ApplicationRecord
  belongs_to :arrival, class_name: :Airport, foreign_key: 'arrival_id'
  belongs_to :departure, class_name: :Airport, foreign_key: 'departure_id'
end
