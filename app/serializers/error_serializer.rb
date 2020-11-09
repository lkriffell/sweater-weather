class ErrorSerializer
  include FastJsonapi::ObjectSerializer
  set_id { nil }
  attributes :message
end
