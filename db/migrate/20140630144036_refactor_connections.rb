class RefactorConnections < ActiveRecord::Migration
  def up
    add_column :connections, :type, :string
    add_column :connections, :status, :string
    add_column :connections, :description, :text

    remove_index :connections, [:user2_id, :user1_id]
    remove_index :connections, [:user1_id, :user2_id]

    add_index :connections, [:user1_id, :user2_id]
  end

  def down
    remove_column :connections, :type, :string
    remove_column :connections, :status, :string
    remove_column :connections, :description, :text
  end
end
