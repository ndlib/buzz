require "rails_helper"

describe SerializeAudioFile do
  let(:params) {{ media_type: "media type" }}
  let(:attributes) {{ "id" => 1, "uuid" => "87ea8e9c-5932-478e-95d8-aeb04888a89a", "media_type" => "media type", "file_path" => "file path" }}
  let(:media) { MediaFile.new(attributes) }
  let(:audio_object) {{
    :@context=>"http://schema.org",
    :@type=>"AudioObject",
    :@id=>"87ea8e9c-5932-478e-95d8-aeb04888a89a",
    :description=>"file path",
    :name=>"file path",
    :thumbnailUrl=>"https://test.host/audio.jpg",
    :uploadDate=>nil,
    :embedUrl=>"https://test.host/?id=87ea8e9c-5932-478e-95d8-aeb04888a89a",
    :contentUrl=>
      [
        "http://wowza.library.nd.edu:1935/buzz_wow/_definst_/mp3:amazons3/buzz-bucket.library.nd.edu/file path/playlist.m3u8",
        "rtmp://wowza.library.nd.edu:1935/buzz_wow/_definst_/mp3:amazons3/buzz-bucket.library.nd.edu/file path"
      ],
    :url=>"http://test.host/v1/media_files/87ea8e9c-5932-478e-95d8-aeb04888a89a"
  }}

  describe "to_hash" do
    let(:subject) { SerializeAudioFile.to_hash(object: media) }

    it "excludes id" do
      expect(subject).not_to include(:"id")
    end

    it "includes all other attributes" do
      expect(subject).to eq(audio_object)
    end
  end

  describe "to_json" do
    let(:subject) { JSON.parse(SerializeAudioFile.to_json(object: media), symbolize_names: true) }

    it "excludes id" do
      expect(subject).not_to include(:"id")
    end

    it "includes all other attributes" do
      expect(subject).to eq(audio_object)
    end
  end
end
