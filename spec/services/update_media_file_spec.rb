require "rails_helper"

describe UpdateMediaFile do
  let(:params) { { media_type: "media type" } }
  let(:media) { instance_double(MediaFile, "attributes=": true) }
  let(:subject) { UpdateMediaFile.call(media: media, params: params) }

  it "returns true when save succeeds" do
    allow(media).to receive(:save).and_return(true)
    expect(subject).to eq(true)
  end

  it "returns false when save fails" do
    allow(media).to receive(:save).and_return(false)
    expect(subject).to eq(false)
  end
end
