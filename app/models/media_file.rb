class MediaFile < ActiveRecord::Base
  validates :file_path, :media_type, presence: true
end
