class Barrel < ApplicationRecord
  belongs_to :satellite
  
  def last_updated_at
    self.satellite.telemetry_timestamp
  end
end