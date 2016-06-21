FactoryGirl.define do
  factory :bird do
    # TODO use Faker to get
    name "Penguin"
    family  "Pengniu"
    continents  ["Antarctica"]
    added "2016-10-12"
    visible true

    trait :invisible do
      visible false
    end
    factory :invisible_bird,    traits: [:invisible]
  end

end
