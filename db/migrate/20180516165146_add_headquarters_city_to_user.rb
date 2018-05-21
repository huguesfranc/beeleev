class AddHeadquartersCityToUser < ActiveRecord::Migration
  def change
    add_column :users, :headquarters_city, :string
  end
end
