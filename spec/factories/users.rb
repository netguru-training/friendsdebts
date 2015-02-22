FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@mail.com" }
    password "12345678"
  end

end
