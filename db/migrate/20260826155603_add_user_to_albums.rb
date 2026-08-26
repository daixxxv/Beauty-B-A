class AddUserToAlbums < ActiveRecord::Migration[7.2]
  def change
    add_reference :albums, :user, null: false, foreign_key: true
  end
end
