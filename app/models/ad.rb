class Ad < ActiveRecord::Base
=begin
  id: integer,
  ad_type: string,
  user_id: integer,
  ad_content: text,
  illustration: string,
  ad_link: string,
  click: integer,
  title: string,
  created_at: datetime,
  updated_at: datetime,
=end
  belongs_to :user

  validates :title, presence: true
  validates :ad_type, presence: true
  validates :ad_content, presence: true
  validates :ad_link, presence: true
  # validates :illustration, presence: true
end
