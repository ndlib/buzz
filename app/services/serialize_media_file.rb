class SerializeMediaFile
  def self.from_hash(hash:)
    MediaFile.new(hash)
  end

  def self.to_json(object:)
    object.to_json(except: :id)
  end
end
