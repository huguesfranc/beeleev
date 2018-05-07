class DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :alert_and_redirect_to_edit_pack, unless: :pack_allows_access?

  def index
    @documents = Document.all
  end

  protected

  def pack_allows_access?
    !current_user.pack.free_access?
  end

  def alert_and_redirect_to_edit_pack
    redirect_to packs_path, alert: 'Your cannot access documents with a free access pack.'
  end
end
