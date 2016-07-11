class MediaFile < ActiveRecord::Base
  validates :file_path, :media_type, :uuid, presence: true
end
