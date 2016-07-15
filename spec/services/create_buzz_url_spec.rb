require "rails_helper"

describe CreateBuzzUrl do
  let(:options) { {host: "test.com", port: "1000", protocol: "http"} }

  before(:each) do
    allow(Rails.application.routes).to receive(:default_url_options).and_return(options)
  end

  it "returns the base path if no uri is given" do
    expect(CreateBuzzUrl.call).to eq("http://test.com:1000")
  end

  it "returns the host path without port if no port is given" do
    options.delete(:port)
    expect(CreateBuzzUrl.call).to eq("http://test.com")
  end

  it "appends the given uri" do
    expect(CreateBuzzUrl.call("my/uri")).to eq("http://test.com:1000/my/uri")
  end
end
