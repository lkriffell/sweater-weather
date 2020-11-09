class Route
  def initialize(route_params)
    @distance = "#{route_params[:route][:distance].round(2)} miles"
  end
end
