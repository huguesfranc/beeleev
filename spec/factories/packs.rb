# == Schema Information
#
# Table name: packs
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  stripe_charge_id :integer
#  kind             :integer
#  created_at       :datetime
#  updated_at       :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pack do
    user nil
    kind 1
  end
end
