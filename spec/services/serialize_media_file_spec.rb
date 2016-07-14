require "rails_helper"

describe SerializeMediaFile do
  let(:params) { {media_type: "media type"} }
  let(:attributes) do
    {
      "id" => 1,
      "uuid" => "87ea8e9c-5932-478e-95d8-aeb04888a89a",
      "media_type" => "media type",
      "file_path" => "file path"
    }
  end
  let(:media) { MediaFile.new(attributes) }

  describe "from_hash" do
    it "creates a new media object" do
      expect(SerializeMediaFile.from_hash(hash: attributes)).to be_a(MediaFile)
    end

    it "assigns the attributes from the hash" do
      expect(SerializeMediaFile.from_hash(hash: attributes).attributes).to include(attributes)
    end

    it "raises an error for an invalid param" do
      attributes["blah"] = "bleh"
      expect { SerializeMediaFile.from_hash(hash: attributes) }.to raise_error(ActiveModel::UnknownAttributeError)
    end
  end

  context "when its an audio type" do
    let(:attributes) do
      {
        "id" => 1,
        "uuid" => "87ea8e9c-5932-478e-95d8-aeb04888a89a",
        "media_type" => "audio",
        "file_path" => "file path"
      }
    end

    it "uses SerializeAudioFile.to_hash" do
      expect(SerializeAudioFile).to receive(:to_hash).with(object: media)
      SerializeMediaFile.to_hash(object: media)
    end

    it "uses SerializeAudioFile.to_hash to convert to json" do
      expect(SerializeAudioFile).to receive(:to_hash).with(object: media)
      SerializeMediaFile.to_json(object: media)
    end
  end

  context "when its a video type" do
    let(:attributes) do
      {
        "id" => 1,
        "uuid" => "87ea8e9c-5932-478e-95d8-aeb04888a89a",
        "media_type" => "video",
        "file_path" => "file path"
      }
    end

    it "uses SerializeVideoFile.to_hash" do
      expect(SerializeVideoFile).to receive(:to_hash).with(object: media)
      SerializeMediaFile.to_hash(object: media)
    end

    it "uses SerializeVideoFile.to_hash to convert to json" do
      expect(SerializeVideoFile).to receive(:to_hash).with(object: media)
      SerializeMediaFile.to_json(object: media)
    end
  end

  context "when its an unknown type" do
    let(:attributes) do
      {
        "id" => 1,
        "uuid" => "87ea8e9c-5932-478e-95d8-aeb04888a89a",
        "media_type" => "this type is unknown",
        "file_path" => "file path"
      }
    end

    it "uses SerializeUnknownTypeFile.to_hash" do
      expect(SerializeUnknownTypeFile).to receive(:to_hash).with(object: media)
      SerializeMediaFile.to_hash(object: media)
    end

    it "uses SerializeUnknownTypeFile.to_hash to convert to json" do
      expect(SerializeUnknownTypeFile).to receive(:to_hash).with(object: media)
      SerializeMediaFile.to_json(object: media)
    end
  end
end
