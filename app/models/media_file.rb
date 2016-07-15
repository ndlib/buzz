class MediaFile < ActiveRecord::Base
  validates :file_path, :uuid, presence: true
  validates_inclusion_of :media_type, in: %w( video audio ), message: "'%{value}' is not valid"
end
