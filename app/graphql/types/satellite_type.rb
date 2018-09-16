Types::SatelliteType = GraphQL::ObjectType.define do
  name 'Satellite'
  
  field :id, !types.ID
  field :telemetry_timestamp, types.Int
  field :barrels, types[Types::BarrelType]
end