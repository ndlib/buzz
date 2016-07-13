require "rails_helper"

describe SerializeCompletedUpdateAction do
  let(:object_serializer) { double(Object, to_hash: "json from object_serializer") }
  let(:object) { double(Object, errors: { "field": "error" }) }


  describe "to_hash" do
    let(:subject) { SerializeCompletedUpdateAction.to_hash(object: object, object_serializer: object_serializer) }

    it "renders the correct context" do
      expect(subject).to include("@context": "http://schema.org")
    end

    it "renders the correct type" do
      expect(subject).to include("@type": "UpdateAction")
    end

    it "renders the correct status" do
      expect(subject).to include(actionStatus: "CompletedActionStatus")
    end

    it "renders the object as json using the object serializer" do
      expect(subject).to include(object: "json from object_serializer")
    end
  end

  describe "to_json" do
    let(:subject) { JSON.parse(SerializeCompletedUpdateAction.to_json(object: object, object_serializer: object_serializer)) }

    it "can be parsed as a json" do
      expect{ subject }.not_to raise_error
    end

    it "renders the correct context" do
      expect(subject).to include("@context" => "http://schema.org")
    end

    it "renders the correct type" do
      expect(subject).to include("@type" => "UpdateAction")
    end

    it "renders the correct status" do
      expect(subject).to include("actionStatus" => "CompletedActionStatus")
    end

    it "renders the object as json using the object serializer" do
      expect(subject).to include("object" => "json from object_serializer")
    end
  end
end
