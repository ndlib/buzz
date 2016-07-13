require "rails_helper"

describe SerializeFailedUpdateAction do
  let(:object_serializer) { double(Object, to_hash: "json from object_serializer") }
  let(:object) { double(Object, errors: { "field" => "error" }) }

  describe "to_hash" do
    let(:subject) { SerializeFailedUpdateAction.to_hash(object: object, object_serializer: object_serializer) }

    it "renders the correct context" do
      expect(subject).to include("@context": "http://schema.org")
    end

    it "renders the correct type" do
      expect(subject).to include("@type": "UpdateAction")
    end

    it "renders the correct status" do
      expect(subject).to include(actionStatus: "FailedActionStatus")
    end

    it "renders any errors attached to the object" do
      expect(subject).to include(error: [{name: "field", description: "error"}])
    end

    it "renders the object as json using the object serializer" do
      expect(subject).to include(object: "json from object_serializer")
    end
  end

  describe "to_json" do
    let(:subject) { JSON.parse(SerializeFailedUpdateAction.to_json(object: object, object_serializer: object_serializer)) }

    it "renders the correct context" do
      expect(subject).to include("@context" => "http://schema.org")
    end

    it "renders the correct type" do
      expect(subject).to include("@type" => "UpdateAction")
    end

    it "renders the correct status" do
      expect(subject).to include("actionStatus" => "FailedActionStatus")
    end

    it "renders any errors attached to the object" do
      expect(subject).to include("error" => [{"name"=>"field", "description"=>"error"}])
    end

    it "renders the object as json using the object serializer" do
      expect(subject).to include("object" => "json from object_serializer")
    end
  end
end
