# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ad do
    type ""
    user nil
    content "MyText"
    illustration "MyString"
    link "MyString"
    click 1
  end
end
