class QueryMediaFile
  def self.find(uuid:)
    MediaFile.where(uuid: uuid).take!
  end
end
