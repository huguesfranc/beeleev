# == Schema Information
#
# Table name: documents
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  file        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :document do
    name "MyString"
    description "MyString"
    file "MyString"
  end
end
