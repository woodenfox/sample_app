# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :micropost do
    content "Lorium Ipsum dolor"
    user
  end
end
