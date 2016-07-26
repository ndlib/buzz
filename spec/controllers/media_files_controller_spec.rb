require "rails_helper"

RSpec.describe MediaFilesController, type: :controller do
  describe "create" do
    let(:subject) { post :create, params: params }
    let(:params) { {media_file: {file_path: "file path", media_type: "media type", thumbnail_url: "http://test.host/video.jpg"}} }
    let(:media) { instance_double(MediaFile, media_type: "media type", attributes: {}, valid?: true) }

    it "throws an exception if the media_file parameter is missing" do
      params.delete(:media_file)
      expect { subject }.to raise_error(ActionController::ParameterMissing)
    end

    it "uses the CreateMediaFile service" do
      expect(CreateMediaFile).to receive(:call).and_return(media)
      subject
    end

    context "when media is valid" do
      let(:media) do
        instance_double(MediaFile,
                        "media_type": "media type",
                        "attributes": {},
                        "uuid=": true,
                        "save": true,
                        "valid?": true)
      end

      before(:each) do
        allow(MediaFile).to receive(:new).and_return(media)
      end

      it "renders 200" do
        subject
        expect(response.status).to eq(200)
      end

      it "uses SerializeCompletedCreateAction to render the json" do
        expect(SerializeCompletedCreateAction).to receive(:to_json)
          .with(object: media, object_serializer: SerializeMediaFile)
        subject
      end
    end

    context "when media is invalid" do
      let(:media) do
        instance_double(MediaFile,
                        "media_type": "media type",
                        "attributes": {},
                        "uuid=": true,
                        "save": false,
                        "valid?": false,
                        "errors": ["validation errors"])
      end

      before(:each) do
        allow(MediaFile).to receive(:new).and_return(media)
      end

      it "renders 422 when given invalid parameters" do
        subject
        expect(response.status).to eq(422)
      end

      it "uses SerializeFailedCreateAction to render the json" do
        expect(SerializeFailedCreateAction).to receive(:to_json)
          .with(object: media, object_serializer: SerializeMediaFile)
        subject
      end
    end
  end

  describe "update" do
    let(:subject) { put :update, params: params }
    let(:params) { {id: "1", media_file: {file_path: "file path", media_type: "media type", thumbnail_url: "http://test.host/video.jpg"}} }
    let(:media) do
      instance_double(MediaFile,
                      "media_type": "media type",
                      "attributes": {},
                      "attributes=": true,
                      "valid?": true,
                      "save": true)
    end

    before(:each) do
      allow(QueryMediaFile).to receive(:find).with(uuid: params[:id]).and_return(media)
    end

    it "throws an exception if the media_file parameter is missing" do
      params.delete(:media_file)
      expect { subject }.to raise_error(ActionController::ParameterMissing)
    end

    it "uses the UpdateMediaFile service" do
      expect(UpdateMediaFile).to receive(:call).and_return(media)
      subject
    end

    context "when media is valid" do
      let(:media) do
        instance_double(MediaFile,
                        "media_type": "media type",
                        "attributes": {},
                        "attributes=": true,
                        "uuid=": true,
                        "save": true,
                        "valid?": true)
      end

      before(:each) do
        allow(QueryMediaFile).to receive(:find).with(uuid: params[:id]).and_return(media)
      end

      it "renders 200" do
        subject
        expect(response.status).to eq(200)
      end

      it "uses SerializeCompletedUpdateAction to render the json" do
        expect(SerializeCompletedUpdateAction).to receive(:to_json)
          .with(object: media, object_serializer: SerializeMediaFile)
        subject
      end
    end

    context "when media is invalid" do
      let(:media) do
        instance_double(MediaFile,
                        "media_type": "media type",
                        "attributes": {},
                        "attributes=": true,
                        "uuid=": true,
                        "save": false,
                        "valid?": false,
                        "errors": ["validation errors"])
      end

      before(:each) do
        allow(QueryMediaFile).to receive(:find).with(uuid: params[:id]).and_return(media)
      end

      it "renders 422 when given invalid parameters" do
        subject
        expect(response.status).to eq(422)
      end

      it "uses SerializeFailedUpdateAction to render the json" do
        expect(SerializeFailedUpdateAction).to receive(:to_json)
          .with(object: media, object_serializer: SerializeMediaFile)
        subject
      end
    end
  end

  describe "show" do
    let(:subject) { get :show, params: params }
    let(:params) { {id: "1"} }
    let(:media) do
      instance_double(MediaFile,
                      "media_type": "media type",
                      "attributes": {},
                      "attributes=": true,
                      "valid?": true,
                      "save": true)
    end

    it "uses QueryMediaFile to find the object" do
      expect(QueryMediaFile).to receive(:find).with(uuid: params[:id]).and_return(media)
      subject
    end
  end
end
