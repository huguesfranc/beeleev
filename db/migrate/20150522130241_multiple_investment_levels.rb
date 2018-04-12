class MultipleInvestmentLevels < ActiveRecord::Migration
  def change
    # create the new investment_levels array attribute
    add_column :users, :investment_levels, :string, array: true, default: []

    # remove the singular business_sector attribute
    remove_column :users, :investment_level
  end
end
