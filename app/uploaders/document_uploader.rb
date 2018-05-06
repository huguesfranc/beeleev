class DocumentUploader < BeeleevUploader

  # Instance methods
  ##################

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
  end

  # WARNING : this must only be used with Cloudinary in production.
  def public_id
    Cloudinary::PreloadedFile.split_format(original_filename).first +
      '_' +
      Cloudinary::Utils.random_public_id[0, 6]
  end

  def extension_white_list
    %w(pdf doc zip docx xls csv)
  end
end
