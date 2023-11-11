FactoryBot.define do
  factory :user do
    name                  { 'test_name' }
    email                 { 'test@example.com' }
    password              { 'test_password' }
    password_confirmation { 'test_password' }
    admin                 { false }
  end
end
