# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    subject "MyString"
    body "MyString"
    user_id "MyString"
  end
end
