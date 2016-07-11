require "rails_helper"

describe SerializeCompletedCreateAction do
  let(:object_serializer) { double(Object, to_json: "\"json from object_serializer\"") }
  let(:object) { double(Object, errors: { "field": "error" }) }
  let(:subject) { JSON.parse(SerializeCompletedCreateAction.to_json(object: object, object_serializer: object_serializer)) }

  it "renders the correct context" do
    expect(subject).to include("@context" => "http://schema.org")
  end

  it "renders the correct type" do
    expect(subject).to include("@type" => "CreateAction")
  end

  it "renders the correct status" do
    expect(subject).to include("actionStatus" => "CompletedActionStatus")
  end

  it "renders the object as json using the object serializer" do
    expect(subject).to include("object" => "json from object_serializer")
  end
end
