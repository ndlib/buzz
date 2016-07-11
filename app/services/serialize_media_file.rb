class SerializeMediaFile
  def self.from_hash(hash:)
    MediaFile.new(hash)
  end

  def self.to_hash(object:)
    object.attributes.except("id")
  end

  def self.to_json(object:)
    to_hash(object: object).to_json
  end
end
