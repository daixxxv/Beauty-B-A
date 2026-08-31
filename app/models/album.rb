class Album < ApplicationRecord
    belongs_to :user
    has_many :records, dependent: :destroy
    has_many :album_records, dependent: :destroy

    accepts_nested_attributes_for :album_records, allow_destroy: true, reject_if: :all_blank

    validates :title, presence: true
    validates :started_on, presence: true

    has_one_attached :before_image
    has_one_attached :after_image

    belongs_to :before_record, class_name: "Record", optional: true
    belongs_to :after_record, class_name: "Record", optional: true
end
