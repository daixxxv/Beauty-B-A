class AddStartedOnToAlbums < ActiveRecord::Migration[7.2]
  def change
    add_column :albums, :started_on, :date
  end
end
