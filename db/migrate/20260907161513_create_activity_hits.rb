class CreateActivityHits < ActiveRecord::Migration[8.1]
  def change
    create_table :activity_hits do |t|
      t.integer :activity_id
      t.date :date

      t.index :activity_id
      t.index :date

      t.timestamps
    end
  end
end
