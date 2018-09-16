class Satellite < ApplicationRecord
  has_many :barrels
  
  validates :telemetry_timestamp, presence: true
end