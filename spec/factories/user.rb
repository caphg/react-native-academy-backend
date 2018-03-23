# frozen_string_literal: true
FactoryGirl.define do
  factory :user, class: User do

    name Faker::HeyArnold.character
    email Faker::Internet.email
    password '12345678'

    todos {[FactoryGirl.create(:todo)]}
  end
end
