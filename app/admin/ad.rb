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

  controller do
    def create
      create! do |format|
        redirect_to(admin_ads_path, notice: "Ad created") and return
      end
    end

    def destroy
      super do |format|
        redirect_to(admin_ads_path, notice: "Ad deleted") and return
      end
    end

    def update
      super do |format|
        redirect_to(admin_ad_path(resource), notice: "Ad updated") and return if resource.valid?
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :user
      f.input :title
      f.input(
          :ad_type,
          label: "Type",
          as: :select, collection: ["Recruitment", "Funding"]
      )
      f.input :ad_content, as: :text
      f.input :illustration
      f.input :ad_link, label: "Link"
    end

    f.actions
  end
end
