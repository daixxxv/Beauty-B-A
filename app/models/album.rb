class Album < ApplicationRecord
    belongs_to :user

    validates :title, presence: true
    validates :started_on, presence: true
end
