Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :barrels, !types[Types::BarrelType] do
    argument :order, types.String
    argument :attribute, types.String
    
    resolve -> (obj, args, ctx) {
      BarrelSorter.new(args[:attribute], args[:order]).sort
    }
  end
  
  field :satellites, !types[Types::SatelliteType] do
    resolve -> (obj, args, ctx) {
      Satellite.all
    }
  end
end

class BarrelSorter
  def initialize(attribute = "id", order = "asc")
    @attribute = attribute.to_sym
    @order = order.upcase
  end
  
  def sort
    barrels = Barrel.all
    barrels = barrels.order(@attribute)
    
    if @order = "DESC"
      barrels = barrels.reverse
    end
    
    barrels
  end
end
