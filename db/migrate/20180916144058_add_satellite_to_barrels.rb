class AddSatelliteToBarrels < ActiveRecord::Migration[5.2]
  def change
    add_reference :barrels, :satellite, foreign_key: true
  end
end
