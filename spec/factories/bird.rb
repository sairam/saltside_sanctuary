FactoryGirl.define do
  factory :bird do
    name "John"
    family  "Doe"
    continents  ["Doe"]
    added "2016-10-12"
    visible true

    trait :invisible do
      visible false
    end
    factory :invisible_bird,    traits: [:invisible]
  end

end
