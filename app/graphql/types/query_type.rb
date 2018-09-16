Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :barrels, !types[Types::BarrelType] do
    argument :order, types.String
    argument :attribute, types.String
    argument :search_term, types.String
    
    resolve -> (obj, args, ctx) {
      BarrelSorter.new(args[:attribute], args[:order], args[:search_term]).sort
    }
  end
  
  field :satellites, !types[Types::SatelliteType] do
    resolve -> (obj, args, ctx) {
      Satellite.all
    }
  end
end

class BarrelSorter
  def initialize(attribute = "id", order = "asc", search_term = nil)
    @attribute = attribute.to_sym if attribute
    @order = order.upcase if order
    @search_term = search_term.to_s if search_term
  end
  
  def sort
    barrels = Barrel.all
    
    if @search_term
      barrels = barrels.where('status LIKE :search_term
                               OR :search_term = ANY (error_messages)
                               OR last_flavor_sensor_result LIKE :search_term', 
                               search_term: @search_term)
    end
    
    if @attribute == :last_updated_at
      barrels = barrels.sort_by { |barrel| barrel.last_updated_at }
    else
      barrels = barrels.order(@attribute)
    end
    
    if @order = "DESC"
      barrels = barrels.reverse
    end
    
    barrels
  end
end
