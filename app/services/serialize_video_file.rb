class SerializeVideoFile
  def self.to_hash(object:)
    {
      "@context": "http://schema.org",
      "@type": "VideoObject",
      "@id": object.uuid,
      "description": object.file_path,
      "name": object.file_path,
      "thumbnailUrl": CreateBuzzUrl.call("video.jpg"),
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
