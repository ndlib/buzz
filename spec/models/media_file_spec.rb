require "rails_helper"

RSpec.describe MediaFile do
  it "requires the file_path field" do
    expect(subject).to have(1).errors_on(:file_path)
  end

  it "requires the uuid field" do
    expect(subject).to have(1).errors_on(:uuid)
  end

  it "accepts thumbnail_url" do
    subject.thumbnail_url = "http://test.host/video.jpg"
    expect(subject).to have(0).errors_on(:thumbnail_url)
  end

  describe "media_type validator" do
    it "requires a value" do
      expect(subject).to have(1).errors_on(:media_type)
    end

    it "accepts video" do
      subject.media_type = "video"
      expect(subject).to have(0).errors_on(:media_type)
    end

    it "accepts audio" do
      subject.media_type = "audio"
      expect(subject).to have(0).errors_on(:media_type)
    end

    it "does not accept empty string" do
      subject.media_type = ""
      expect(subject).to have(1).errors_on(:media_type)
    end

    it "does not accept unknown value" do
      subject.media_type = "something"
      expect(subject).to have(1).errors_on(:media_type)
    end
  end
end
