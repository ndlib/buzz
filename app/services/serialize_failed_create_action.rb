class SerializeFailedCreateAction
  def self.to_json(object:, object_serializer:)
    errors = object.errors.map do |k, v|
      {
        "name": k,
        "description": v
      }
    end

    "{
      \"@context\": \"http://schema.org\",
      \"@type\": \"CreateAction\",
      \"actionStatus\": \"FailedActionStatus\",
      \"object\": #{object_serializer.to_json(object: object)},
      \"error\": #{errors.to_json}
    }"
  end
end
