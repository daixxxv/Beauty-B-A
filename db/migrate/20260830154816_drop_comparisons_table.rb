class DropComparisonsTable < ActiveRecord::Migration[7.2]
  def change
    drop_table :comparisons do |t|
      t.references :album, null: false, foreign_key: true
      t.string :title
      t.text :memo
      t.date :before_date
      t.date :after_date
      t.timestamps
    end
  end
end
