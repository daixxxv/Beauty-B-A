FactoryBot.define do
  factory :album_record do
    association :album

    trait :with_images do
      before_image { Rack::Test::UploadedFile.new(Rails.root.join("test/fixtures/files/sample.png"), "image/png") }
      after_image { Rack::Test::UploadedFile.new(Rails.root.join("test/fixtures/files/sample.png"), "image/png") }
    end
  end
end