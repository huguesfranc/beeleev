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

require 'spec_helper'

describe Pack do
  pending "add some examples to (or delete) #{__FILE__}"
end
