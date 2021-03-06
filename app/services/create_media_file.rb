class CreateMediaFile
  attr_reader :params

  def self.call(params:)
    new(params).create!
  end

  def initialize(params)
    @params = params
  end

  def create!
    media = SerializeMediaFile.from_hash(hash: params)
    media.uuid = SecureRandom.uuid
    media.save
    media
  end
end
