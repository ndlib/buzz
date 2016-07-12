class UpdateMediaFile
  attr_reader :media, :params

  def self.call(media:, params:)
    new(media: media, params: params).update!
  end

  def initialize(media:, params:)
    @media = media
    @params = params
  end

  def update!
    media.attributes = params
    media.save
  end
end
