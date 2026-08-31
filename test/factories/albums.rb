FactoryBot.define do
  factory :album do
    association :user
    title { "My Great Album" }
    started_on { Date.today }
  end
end