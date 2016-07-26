class AddThumbnailUrlToMediaFile < ActiveRecord::Migration[5.0]
  def change
    add_column :media_files, :thumbnail_url, :string
  end
end
