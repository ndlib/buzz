require "rails_helper"

RSpec.describe MediaFilesController, type: :controller do
  let(:media) { instance_double(MediaFile, "uuid=": true, valid?: true, errors: "validation errors") }

  before(:each) do
    allow(MediaFile).to receive(:new).and_return(media)
    allow(media).to receive(:save).and_return(true)
  end

  describe "create" do
    let(:subject) { post :create, params: params }
    let(:params) { { media_file: { file_path: "file path", media_type: "media type" } } }

    it "uses the CreateMediaFile service" do
      expect(CreateMediaFile).to receive(:call).and_return(media)
      subject
    end

    it "uses SerializeCompletedCreateAction to render the json" do
      expect(SerializeCompletedCreateAction).to receive(:to_json).with(object: media, object_serializer: SerializeMediaFile)
      subject
    end

    it "throws an exception if the media_file parameter is missing" do
      params.delete(:media_file)
      expect{ subject }.to raise_error(ActionController::ParameterMissing)
    end

    it "renders errors if the media is invalid" do
      allow(media).to receive(:valid?).and_return(false)
      expect(SerializeFailedCreateAction).to receive(:to_json).with(object: media, object_serializer: SerializeMediaFile)
      subject
    end
  end
end
