class AddPackToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pack, :integer
  end
end
