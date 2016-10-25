class CreateContentUrl
  def self.http(object:)
    "http://#{settings["host"]}:#{settings["port"]}" \
          "/#{settings["application"]}/#{settings["instance"]}" \
          "/#{prefix(object:object)}:#{settings["cache_source_prefix"]}/#{settings["cache_source"]}" \
          "/#{object.file_path}/playlist.m3u8"
  end

  def self.rtmp(object:)
    "rtmp://#{settings["host"]}:#{settings["port"]}" \
          "/#{settings["application"]}/#{settings["instance"]}" \
          "/#{prefix(object:object)}:#{settings["cache_source_prefix"]}/#{settings["cache_source"]}" \
          "/#{object.file_path}"
  end

  private

  def self.prefix(object:)
    if object.media_type.casecmp("video") || File.extname(object.file_path).casecmp(".m4a")
      "mp4"
    else
      "mp3"
    end
  end

  def self.settings
    settings ||= Rails.configuration.settings.wowza
  end
end
