class SerializeAudioFile
  def self.to_hash(object:)
    {
      "@context": "http://schema.org",
      "@type": "AudioObject",
      "@id": object.uuid,
      "description": object.file_path,
      "name": object.file_path,
      "thumbnailUrl": object.thumbnail_url,
      "uploadDate": object.updated_at,
      "embedUrl": CreateBuzzUrl.call("?id=#{object.uuid}"),
      "contentUrl": [
        CreateContentUrl.http(object: object),
        CreateContentUrl.rtmp(object: object),
      ],
      "url": Rails.application.routes.url_helpers.media_file_url(object.uuid)
    }
  end

  def self.to_json(object:)
    to_hash(object: object).to_json
  end
end
