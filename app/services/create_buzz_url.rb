class CreateBuzzUrl
  def self.call(uri = nil)
    host = Rails.application.routes.default_url_options[:host]
    port = Rails.application.routes.default_url_options[:port]

    port_suffix = ":#{port}" if port.present?
    uri_suffix = "/#{uri}" if uri.present?

    "https://#{host}#{port_suffix}#{uri_suffix}"
  end
end
