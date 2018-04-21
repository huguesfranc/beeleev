class AddPackToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :pack, index: true
  end
end
