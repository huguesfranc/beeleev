class Document < ActiveRecord::Base
  validates :name, presence: true

  mount_uploader :file, DocumentUploader
end
