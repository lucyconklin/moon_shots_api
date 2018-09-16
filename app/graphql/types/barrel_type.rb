Types::BarrelType = GraphQL::ObjectType.define do
  name 'Barrel'
  
  field :id, !types.ID
  field :last_flavor_sensor_result, types.String
  field :status, types.String
  field :error_messages, types[types.String]
  field :last_updated_at, types.Int
end