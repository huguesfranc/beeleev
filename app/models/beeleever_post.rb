# == Schema Information
#
# Table name: posts
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  subtitle           :text
#  text               :string(255)
#  body               :text
#  illustration       :string(255)
#  published          :boolean          default(FALSE)
#  publication_date   :date             default(Mon, 09 Apr 2018)
#  created_at         :datetime
#  updated_at         :datetime
#  detailed_body      :text
#  type               :string(255)
#  author_id          :integer
#  embedded_video_tag :text
#

class BeeleeverPost < Post

  # Associations
  ##############

  has_many :comments, dependent: :destroy

end
