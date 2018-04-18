class AddProfessionalStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :professional_status, :integer, default: 1
  end
end
