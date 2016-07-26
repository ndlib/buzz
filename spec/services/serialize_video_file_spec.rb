require "rails_helper"

describe SerializeVideoFile do
  let(:params) { {media_type: "media type"} }
  let(:attributes) do
    {
      "id" => 1,
      "uuid" => "87ea8e9c-5932-478e-95d8-aeb04888a89a",
      "media_type" => "media type",
      "file_path" => "file path",
      "thumbnail_url" => "http://test.host/video.jpg"
    }
  end
  let(:media) { MediaFile.new(attributes) }
  let(:audio_object) do
    {
      :@context => "http://schema.org",
      :@type => "VideoObject",
      :@id => "87ea8e9c-5932-478e-95d8-aeb04888a89a",
      :description => "file path",
      :name => "file path",
      :thumbnailUrl => "http://test.host/video.jpg",
      :uploadDate => nil,
      :embedUrl => "http://test.host/?id=87ea8e9c-5932-478e-95d8-aeb04888a89a",
      :contentUrl => [
        "http://wowza.library.nd.edu:1935/buzz_wow/_definst_/mp3:amazons3/buzz-bucket.library.nd.edu/file path/playlist.m3u8",
        "rtmp://wowza.library.nd.edu:1935/buzz_wow/_definst_/mp3:amazons3/buzz-bucket.library.nd.edu/file path"
      ],
      :url => "http://test.host/v1/media_files/87ea8e9c-5932-478e-95d8-aeb04888a89a"
    }
  end

  describe "to_hash" do
    let(:subject) { SerializeVideoFile.to_hash(object: media) }

    it "excludes id" do
      expect(subject).not_to include(:id)
    end

    it "includes all other attributes" do
      expect(subject).to eq(audio_object)
    end
  end

  describe "to_json" do
    let(:subject) { JSON.parse(SerializeVideoFile.to_json(object: media), symbolize_names: true) }

    it "excludes id" do
      expect(subject).not_to include(:id)
    end

    it "includes all other attributes" do
      expect(subject).to eq(audio_object)
    end
  end
end
