require 'rails_helper'

RSpec.describe 'route poro' do
  it 'has an attribute called distance' do
    route_params = { route: { distance: 25.2323 } }
    route = Route.new(route_params)

    expect(route).to be_a(Route)
    expect(route.distance).to be_a(String)
    expect(route.distance).to eq("25.23 miles")
  end
end
