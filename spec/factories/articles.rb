FactoryBot.define do
  factory :article do
    title { Faker::Lorem.word }
    text { Faker::Lorem.paragraph(2) }
  end
end