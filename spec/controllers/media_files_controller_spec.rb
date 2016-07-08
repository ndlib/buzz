require "rails_helper"

RSpec.describe MediaFilesController, type: :controller do
  let(:media) { instance_double(MediaFile, "uuid=": true) }

  before(:each) do
    allow(MediaFile).to receive(:new).and_return(media)
    allow(media).to receive(:save).and_return(true)
  end

  describe "create" do
    let(:subject) { post :create, params: params }
    let(:params) { { media_file: { file_path: "file path", media_type: "media type" } } }

    it "uses the CreateMediaFile service" do
      expect(CreateMediaFile).to receive(:call)
      subject
    end

    it "uses SerializeMediaFile to render the json" do
      expect(SerializeMediaFile).to receive(:to_json).with(media_file: media)
      subject
    end

    it "throws an exception if the media_file parameter is missing" do
      params.delete(:media_file)
      expect{ subject }.to raise_error(ActionController::ParameterMissing)
    end
  end
end
