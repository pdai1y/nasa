def configure
  NASA.configure do |c|
    c.api_key = ENV['nasa_api_key']
    c.debug = true
  end
end
