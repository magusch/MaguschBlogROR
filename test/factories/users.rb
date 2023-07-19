FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "qqq@www.corg" }
    password { 'password123' }
  end
end