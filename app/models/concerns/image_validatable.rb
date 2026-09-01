module ImageValidatable
  extend ActiveSupport::Concern

  included do
    validates :before_image,
              content_type: { in: %w[image/png image/jpeg], message: 'は PNG, JPG, JPEG 形式でアップロードしてください' },
              size: { less_than: 10.megabytes, message: 'は 10MB 以下にしてください' },
              allow_nil: true

    validates :after_image,
              content_type: { in: %w[image/png image/jpeg], message: 'は PNG, JPG, JPEG 形式でアップロードしてください' },
              size: { less_than: 10.megabytes, message: 'は 10MB 以下にしてください' },
              allow_nil: true
  end
end