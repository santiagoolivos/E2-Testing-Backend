# frozen_string_literal: true

class Seat < ApplicationRecord
  belongs_to :flight
end
