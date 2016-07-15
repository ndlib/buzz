class SerializeMediaFile
  def self.from_hash(hash:)
    MediaFile.new(hash)
  end

  def self.to_hash(object:)
    type = object.media_type.present? ? object.media_type.downcase : ""
    case type
    when "video"
      SerializeVideoFile.to_hash(object: object)
    when "audio"
      SerializeAudioFile.to_hash(object: object)
    else
      SerializeUnknownTypeFile.to_hash(object: object)
    end
  end

  def self.to_json(object:)
    to_hash(object: object).to_json
  end
end
