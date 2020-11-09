class TrailSerializer
  include FastJsonapi::ObjectSerializer
  set_id { nil }
  
  attributes :name, :summary, :difficulty, :location, :current_conditions, :distance_to_trail
end
