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

  it "returns http for development env" do
    allow(Rails).to receive(:env).and_return("development")
    expect(CreateBuzzUrl.protocol).to eq("http")
  end

  it "returns http for test env" do
    allow(Rails).to receive(:env).and_return("test")
    expect(CreateBuzzUrl.protocol).to eq("http")
  end

  it "returns https for pre_production env" do
    allow(Rails).to receive(:env).and_return("pre_production")
    expect(CreateBuzzUrl.protocol).to eq("https")
  end

  it "returns https for production env" do
    allow(Rails).to receive(:env).and_return("production")
    expect(CreateBuzzUrl.protocol).to eq("https")
  end
end
