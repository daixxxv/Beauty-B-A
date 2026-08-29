class AddSelectedRecordsToAlbums < ActiveRecord::Migration[7.2]
  def change
    add_column :albums, :before_record_id, :bigint
    add_column :albums, :after_record_id, :bigint
  end
end
