class TestDummyMigration < ActiveRecord::Migration[5.0]
  def change
    create_table :health_checks do |t|
      t.timestamps
    end
  end
end
