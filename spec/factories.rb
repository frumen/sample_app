FactoryGirl.define do
  factory :user do
    name     "Michael Hartl"
    email    "michael@example.com"
    password "foobar11"
    password_confirmation "foobar11"
  end
end