# frozen_string_literal: true

class Airport < ApplicationRecord
  has_many :arrivals, class_name: 'Flight', foreign_key: 'arrival_id', dependent: :destroy
  has_many :departures, class_name: 'Flight', foreign_key: 'departure_id', dependent: :destroy
end
