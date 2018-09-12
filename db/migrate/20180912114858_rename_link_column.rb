class RenameLinkColumn < ActiveRecord::Migration
  def change
    rename_column :ads, :link, :ad_link
  end
end
