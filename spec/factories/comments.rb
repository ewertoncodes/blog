FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.paragraph(2) }
  end
end