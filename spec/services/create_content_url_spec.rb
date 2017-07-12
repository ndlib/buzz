require "rails_helper"

describe CreateContentUrl do
  let(:wowza_settings) do
    {
      "host" => "wowza-test.com",
      "port" => "1000",
      "application" => "wowie",
      "instance" => "instance",
      "cache_source_prefix" => "source-prefix",
      "cache_source" => "source"
    }
  end

  before(:each) do
    allow(Rails.configuration.settings).to receive(:wowza).and_return(wowza_settings)
  end

  context "when given a video file" do
    let(:object) { instance_double(MediaFile, media_type: "video", file_path: "file-path") }

    it "renders the correct http url" do
      url = "https://wowza-test.com:1000/wowie/instance/mp4:source-prefix/source/file-path/playlist.m3u8"
      expect(CreateContentUrl.http(object: object)).to eq(url)
    end

    it "renders the correct rtmp url" do
      url = "rtmps://wowza-test.com:1000/wowie/instance/mp4:source-prefix/source/file-path"
      expect(CreateContentUrl.rtmp(object: object)).to eq(url)
    end
  end

  context "when given an audio file" do
    let(:object) { instance_double(MediaFile, media_type: "audio", file_path: "file-path") }

    it "renders the correct http url" do
      url = "https://wowza-test.com:1000/wowie/instance/mp3:source-prefix/source/file-path/playlist.m3u8"
      expect(CreateContentUrl.http(object: object)).to eq(url)
    end

    it "renders the correct rtmp url" do
      url = "rtmps://wowza-test.com:1000/wowie/instance/mp3:source-prefix/source/file-path"
      expect(CreateContentUrl.rtmp(object: object)).to eq(url)
    end
  end

  context "when given an .m4a audio file" do
    let(:object) { instance_double(MediaFile, media_type: "audio", file_path: "file-path.m4a") }

    it "renders the correct http url" do
      url = "https://wowza-test.com:1000/wowie/instance/mp4:source-prefix/source/file-path.m4a/playlist.m3u8"
      expect(CreateContentUrl.http(object: object)).to eq(url)
    end

    it "renders the correct rtmp url" do
      url = "rtmps://wowza-test.com:1000/wowie/instance/mp4:source-prefix/source/file-path.m4a"
      expect(CreateContentUrl.rtmp(object: object)).to eq(url)
    end
  end
end
