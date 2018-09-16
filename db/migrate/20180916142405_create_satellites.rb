class CreateSatellites < ActiveRecord::Migration[5.2]
  def change
    create_table :satellites do |t|
      t.integer :telemetry_timestamp
      
      t.timestamps null: false
    end
  end
end
