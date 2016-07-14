require "rails_helper"

describe SerializeUnknownTypeFile do
  let(:params) { { media_type: "media type" } }
  let(:attributes) { { "id" => 1, "uuid" => "87ea8e9c-5932-478e-95d8-aeb04888a89a", "media_type" => "media type", "file_path" => "file path" } }
  let(:media) { MediaFile.new(attributes) }

  describe "to_hash" do
    let(:subject) { SerializeUnknownTypeFile.to_hash(object: media) }

    it "excludes id" do
      expect(subject).not_to include(:"id")
    end

    it "includes all other attributes" do
      expect(subject).to include("file_path", "media_type")
    end
  end

  describe "to_json" do
    let(:subject) { JSON.parse(SerializeUnknownTypeFile.to_json(object: media), symbolize_names: true) }

    it "excludes id" do
      expect(subject).not_to include(:"id")
    end

    it "includes all other attributes" do
      expect(subject).to include(:"file_path", :"media_type")
    end
  end
end
