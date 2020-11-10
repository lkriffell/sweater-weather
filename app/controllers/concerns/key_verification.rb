module KeyVerification
  def self.valid_key?(key)
    if User.find_by(api_key: key)
      true
    else
      false
    end
  end
end
