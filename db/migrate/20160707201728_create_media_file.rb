class CreateMediaFile < ActiveRecord::Migration[5.0]
  def change
    create_table :media_files do |t|
      t.string :media_type, null: false
      t.string :file_path, null: false
      t.uuid :uuid, null: false
    end
  end
end
