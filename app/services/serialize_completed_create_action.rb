class SerializeCompletedCreateAction
  def self.to_json(object:, object_serializer:)
    "{
      \"@context\": \"http://schema.org\",
      \"@type\": \"CreateAction\",
      \"actionStatus\": \"CompletedActionStatus\",
      \"object\": #{object_serializer.to_json(object: object)}
    }"
  end
end
