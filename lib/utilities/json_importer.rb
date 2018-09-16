require 'faker'
require 'json'
require 'byebug'

class BarrelImporter
  
  def initialize(filepath)
    import_data(filepath)
  end
  
  def import_data(filepath)
    
    # read file
    # parse json
    data = JSON.parse(File.read(filepath))
    satellites_created = 0
    barrels_created = 0
    
    data.each do |satellite|
      telemetry_timestamp = satellite["telemetry_timestamp"]
      id = satellite["id"]
      barrels = satellite["barrels"]
      
      s = Satellite.find_or_create_by(id: id)
      s.telemetry_timestamp = telemetry_timestamp
                                              
      barrels.each do |barrel|
        last_flavor_sensor_result = barrel["last_flavor_sensor_result"]
        status = barrel["status"]
        error_messages = barrel["error_messages"]
        id = barrel["id"]
        
        b = Barrel.find_or_create_by(id: id)
        b.last_flavor_sensor_result = last_flavor_sensor_result
        b.status = status
        b.save
        
        s.barrels << b
        barrels_created += 1
      end
      
      s.save
      satellites_created += 1
    end
    
    show_results(satellites_created, barrels_created)
  end
  
  def show_results(satellites_created, barrels_created)
    print cyan("#{satellites_created} Satellites Created!")
    print magenta("#{barrels_created} Barrels Created!")
  end
  
  def cyan(text)
    "\e[36m#{text}\e[0m"
  end
  
  def magenta(text)
    "\e[35m#{text}\e[0m"
  end
  
end

def create_seed_data(filepath)  
  data = []
  ids = Array(1..5)
  barrel_id = 3
  
  5.times do
    barrel_number = rand(3..7)
    telemetry_timestamp = Time.now.to_i
    satellite_id = ids.slice!(0)
    
    satellite = {}
    
    satellite["telemetry_timestamp"] = telemetry_timestamp
    satellite["id"] = satellite_id
    satellite["barrels"] = []
    
    barrel_number.times do 
      last_flavor_sensor_result = Faker::Dessert.flavor
      status = ["error", "ready", "aging"][rand(0..2)]
      
      if status == "error"
        error_message = "RUD - barrel has exploded"
      else
        error_message = ""
      end
      
      barrel = {}
      
      barrel["id"] = barrel_id
      barrel_id += 1
      
      barrel["last_flavor_sensor_result"] = last_flavor_sensor_result
      barrel["status"] = status
      barrel["error_messages"] = [error_message]

      satellite["barrels"] << barrel
    end
    
    data << satellite
  end
  
  File.open(filepath,"w") do |file|
    file.write(data.to_json)
  end
end

# to use:
# File.load("./lib/utilities/json_importer.rb")
# create_seed_data(filepath)
# BarrelImporter.new(filepath)