require "rails_helper"

describe CreateContentUrl do
  let(:wowza_settings) {{
    "host" => "wowza-test.com",
    "port" => "1000",
    "application" => "wowie",
    "instance" => "instance",
    "cache_source_prefix" => "source-prefix",
    "cache_source" => "source"
  }}

  before(:each) do
    allow(Rails.configuration.settings).to receive(:wowza).and_return(wowza_settings)
    #Rails.configuration.settings.wowza = wowza_settings
  end

  context "when given a video file" do
    let(:object) { instance_double(MediaFile, media_type: "video", file_path: "file-path") }

    it "renders the correct http url" do
      expect(CreateContentUrl.http(object: object)).to eq("http://wowza-test.com:1000/wowie/instance/mp4:source-prefix/source/file-path/playlist.m3u8")
    end

    it "renders the correct rtmp url" do
      expect(CreateContentUrl.rtmp(object: object)).to eq("rtmp://wowza-test.com:1000/wowie/instance/mp4:source-prefix/source/file-path")
    end
  end

  context "when given an audio file" do
    let(:object) { instance_double(MediaFile, media_type: "audio", file_path: "file-path") }

    it "renders the correct http url" do
      expect(CreateContentUrl.http(object: object)).to eq("http://wowza-test.com:1000/wowie/instance/mp3:source-prefix/source/file-path/playlist.m3u8")
    end

    it "renders the correct rtmp url" do
      expect(CreateContentUrl.rtmp(object: object)).to eq("rtmp://wowza-test.com:1000/wowie/instance/mp3:source-prefix/source/file-path")
    end
  end
end
