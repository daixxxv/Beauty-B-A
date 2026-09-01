class Album < ApplicationRecord
    include ImageValidatable

    belongs_to :user
    has_many :album_records, dependent: :destroy

    accepts_nested_attributes_for :album_records, allow_destroy: true, reject_if: :all_blank

    validates :title, presence: true
    validates :started_on, presence: true

    has_one_attached :before_image
    has_one_attached :after_image

    belongs_to :before_record, class_name: "AlbumRecord", optional: true
    belongs_to :after_record, class_name: "AlbumRecord", optional: true
end
