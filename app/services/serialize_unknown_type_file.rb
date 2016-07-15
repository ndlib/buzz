class SerializeUnknownTypeFile
  def self.to_hash(object:)
    object.attributes.except("id", "uuid", "created_at", "updated_at")
  end

  def self.to_json(object:)
    to_hash(object: object).to_json
  end
end
