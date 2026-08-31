class AlbumRecord < ApplicationRecord
  belongs_to :album

  has_one_attached :before_image
  has_one_attached :after_image
end
