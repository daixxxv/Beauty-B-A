class AlbumRecord < ApplicationRecord
  include ImageValidatable

  belongs_to :album

  has_one_attached :before_image
  has_one_attached :after_image

end
