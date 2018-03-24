# frozen_string_literal: true
FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end

  factory :user, class: User do
    name Faker::HeyArnold.character
    email
    password '12345678'

    todos {[FactoryGirl.create(:todo)]}
  end
end
