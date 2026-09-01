FactoryBot.define do
  factory :album do
    association :user
    title { "テストアルバム" }
    started_on { Date.today }
  end
end
