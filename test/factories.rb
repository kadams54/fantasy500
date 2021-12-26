require 'faker'

FactoryBot.define do
  factory :driver do
    name       { Faker::Name.name }
    number     { Faker::Number.non_zero_digit }
    make_model { Faker::Vehicle.make_and_model }

    trait :historical do
      year     { Time.current.year - 50 }
    end
  end
end

FactoryBot.define do
  factory :grid do
    lap   { Faker::Number.within(range: 0..200) }

    trait :start do
      lap { 0 }
    end

    trait :finish do
      lap { 200 }
    end
  end
end

FactoryBot.define do
  factory :position do
    place  { Faker::Number.within(range: 1..33) }
    driver
    grid
  end
end

FactoryBot.define do
  factory :team do
    name { Faker::Team.name }
  end
end

FactoryBot.define do
  factory :league do
    name { Faker::Team.name }
    commish { association :user }
  end
end

FactoryBot.define do
  factory :user do
    name     { Faker::Name.name }
    email    { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }

    trait :active do
      activated    { true }
      activated_at { Time.zone.now }
    end

    trait :inactive do
      activated { false }
    end

    trait :admin do
      admin { true }
    end
  end
end
