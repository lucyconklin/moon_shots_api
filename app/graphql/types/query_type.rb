Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :barrels, !types[Types::BarrelType] do
    resolve -> (obj, args, ctx) {
      Barrel.all
    }
  end
  
  field :satellites, !types[Types::SatelliteType] do
    resolve -> (obj, args, ctx) {
      Satellite.all
    }
  end
end
