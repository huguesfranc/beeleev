ActiveAdmin.register Document do
  permit_params :name, :description, :file

  filter :email

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :download do |resource|
        link_to 'Download', resource.file.url, download: true
      end
    end
  end

  form do |f|
    f.inputs "Document" do
      f.input :name
      f.input :description, as: :text
      f.input :file
    end
    f.actions
  end
end
