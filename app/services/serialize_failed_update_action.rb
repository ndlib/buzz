class SerializeFailedUpdateAction
  def self.to_hash(object:, object_serializer:)
    errors = object.errors.map do |k, v|
      {
        "name": k,
        "description": v
      }
    end

    {
      "@context": "http://schema.org",
      "@type": "UpdateAction",
      "actionStatus": "FailedActionStatus",
      "object": object_serializer.to_hash(object: object),
      "error": errors
    }
  end

  def self.to_json(object:, object_serializer:)
    to_hash(object: object, object_serializer: object_serializer).to_json
  end
end
