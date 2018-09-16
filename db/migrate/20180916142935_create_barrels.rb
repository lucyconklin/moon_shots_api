class CreateBarrels < ActiveRecord::Migration[5.2]
  def change
    create_table :barrels do |t|
      t.string :last_flavor_sensor_result
      t.string :status
      t.string :error_messages, array: true, default: []
      
      t.timestamps
    end
  end
end
