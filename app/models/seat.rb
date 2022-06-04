class Seat < ApplicationRecord
  belongs_to :flight
  belongs_to :user
end
