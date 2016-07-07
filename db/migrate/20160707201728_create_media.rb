class CreateMedia < ActiveRecord::Migration[5.0]
  def change
    create_table :media do |t|
      t.string :media_type, null: false
      t.string :file_name, null: false
      t.string :wowza_app, null: false
      t.uuid :uuid, null: false
      t.json :metadata
    end
  end
end
