class SerializeMediaFile
  def self.from_hash(hash:)
    MediaFile.new(hash)
  end

  def self.to_json(media_file:)
    media_file.to_json(except: :id)
  end
end
