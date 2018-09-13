ActiveAdmin.register Ad do

  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  config.sort_order = 'created_at_desc'
  
  filter :title
  filter :ad_content
  filter :ad_link
  filter :ad_type, as: :select, collection: ["Recruitment", "Funding"]
end
