class CreateRecords < ActiveRecord::Migration[7.2]
  def change
    create_table :records do |t|
      t.references :album, null: false, foreign_key: true
      t.date :recorded_on
      t.text :memo

      t.timestamps
    end
  end
end
