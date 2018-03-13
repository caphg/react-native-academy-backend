# frozen_string_literal: true
FactoryGirl.define do
  factory :todo, class: Todo do
    association :user, factory: :user

    title Faker::Vehicle.vin
    description Faker::Vehicle.manufacture
  end
end
