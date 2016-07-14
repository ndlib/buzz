class AddTimestampsToMediaFile < ActiveRecord::Migration[5.0]
  def change
      add_column(:media_files, :created_at, :datetime)
      add_column(:media_files, :updated_at, :datetime)
  end
end
