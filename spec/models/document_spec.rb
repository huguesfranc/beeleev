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

require 'spec_helper'

describe Document do
  pending "add some examples to (or delete) #{__FILE__}"
end
