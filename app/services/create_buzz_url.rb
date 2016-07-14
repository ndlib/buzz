class CreateBuzzUrl
  def self.call(uri)
    "https://#{Rails.application.routes.default_url_options[:host]}:#{Rails.application.routes.default_url_options[:port]}/#{uri}"
  end
end
