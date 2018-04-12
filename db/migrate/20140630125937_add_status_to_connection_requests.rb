class AddStatusToConnectionRequests < ActiveRecord::Migration
  def change
    add_column :connection_requests, :status, :string
  end
end
