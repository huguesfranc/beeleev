class UpdateTypeColumnName < ActiveRecord::Migration
  def change
    rename_column :ads, :type, :ad_type
  end
end
