FactoryBot.define do
  factory :user do
    first_name { "Test" }
    last_name { "User"}
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "testpassword" }
  end

  factory :friend, class: User do
    first_name { "Friend" }
    last_name { "User"}
    sequence(:email) { |n| "friend#{n}@example.com" }
    password { "testpassword" }
  end
end
