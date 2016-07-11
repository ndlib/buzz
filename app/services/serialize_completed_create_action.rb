class SerializeCompletedCreateAction
  def self.to_hash(object:, object_serializer:)
    {
      "@context": "http://schema.org",
      "@type": "CreateAction",
      "actionStatus": "CompletedActionStatus",
      "object": object_serializer.to_hash(object: object)
    }
  end

  def self.to_json(object:, object_serializer:)
    to_hash(object: object, object_serializer: object_serializer).to_json
  end
end
