ActiveAdmin.register Document do
  permit_params :name, :description, :file

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  controller do
    def create
      super do |format|
        redirect_to admin_document_path(resource), notice: resource.valid? ? "Document created" : "Could not create document"
      end
    end

    def update
      super do |format|
        redirect_to admin_document_path(resource), notice: resource.valid? ? "Document updated" : "Could not update document"
      end
    end

    def destroy
      super do |format|
        redirect_to admin_documents_path, notice: "Document destroyed"
      end
    end
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
