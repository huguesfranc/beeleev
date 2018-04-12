class MultipleBusinessSectorsForRequests < ActiveRecord::Migration
  def change
    add_column :connection_requests, :business_sectors, :text, array: true, default: []
    remove_column :connection_requests, :activity_sector, :text
  end
end
