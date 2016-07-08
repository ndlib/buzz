require "rails_helper"

describe CreateMediaFile do
  let(:params) { { media_type: "media type" } }
  let(:media) { instance_double(MediaFile, "uuid=": true) }
  let(:subject) { CreateMediaFile.call(params: params) }

  context "when save succeeds" do
    before(:each) do
      allow(MediaFile).to receive(:new).and_return(media)
      allow(media).to receive(:save).and_return(true)
    end

    it "returns the new file when save succeeds" do
      expect(subject).to eq(media)
    end

    it "generates the UUID" do
      expect(media).to receive(:uuid=).with(/.+/)
      subject
    end

    it "does not set the uuid based on a parameter" do
      params[:uuid] = "not this"
      expect(media).not_to receive(:uuid=).with("not this")
      subject
    end
  end

  it "returns the new file when save fails" do
    allow(MediaFile).to receive(:new).and_return(media)
    allow(media).to receive(:save).and_return(false)
    expect(subject).to eq(media)
  end

  it "raises an error for an invalid param" do
    params[:blah] = "bleh"
    expect{ subject }.to raise_error(ActiveModel::UnknownAttributeError)
  end
end
