# frozen_string_literal: true
FactoryGirl.define do
  factory :invitation, class: Invitation do
    first_user_id { FactoryGirl.create(:user).id }
    second_user_id { FactoryGirl.create(:user).id }
    todo_id { FactoryGirl.create(:todo).id }
  end
end
