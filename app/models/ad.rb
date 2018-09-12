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
end
