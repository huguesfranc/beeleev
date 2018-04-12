class MakeBusinessSectorsAnArray < ActiveRecord::Migration
  def change
    # create the new business_sectors array attribute
    add_column :users, :business_sectors, :string, array: true, default: []

    # remove the singular business_sector attribute
    remove_column :users, :business_sector
  end
end
