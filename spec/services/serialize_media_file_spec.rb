require "rails_helper"

describe SerializeMediaFile do
  let(:params) { { media_type: "media type" } }
  let(:attributes) { { "id" => 1, "uuid" => "87ea8e9c-5932-478e-95d8-aeb04888a89a", "media_type" => "media type", "file_path" => "file path" } }
  let(:media) { MediaFile.new(attributes) }

  describe "from_hash" do
    it "creates a new media object" do
      expect(SerializeMediaFile.from_hash(hash: attributes)).to be_a(MediaFile)
    end

    it "assigns the attributes from the hash" do
      expect(SerializeMediaFile.from_hash(hash: attributes).attributes).to eq(attributes)
    end

    it "raises an error for an invalid param" do
      attributes["blah"] = "bleh"
      expect{ SerializeMediaFile.from_hash(hash: attributes) }.to raise_error(ActiveModel::UnknownAttributeError)
    end
  end

  describe "to_hash" do
    let(:subject) { SerializeMediaFile.to_hash(object: media) }

    it "excludes id" do
      expect(subject).not_to include(:"id")
    end

    it "includes all other attributes" do
      expect(subject).to include("uuid", "file_path", "media_type")
    end
  end

  describe "to_json" do
    let(:subject) { JSON.parse(SerializeMediaFile.to_json(object: media), symbolize_names: true) }

    it "excludes id" do
      expect(subject).not_to include(:"id")
    end

    it "includes all other attributes" do
      expect(subject).to include(:"uuid", :"file_path", :"media_type")
    end
  end
end
