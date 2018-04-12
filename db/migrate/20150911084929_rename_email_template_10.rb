class RenameEmailTemplate10 < ActiveRecord::Migration
  def change
    add_column :users, :activate_user_reminder_count, :integer, default: 0
  end
end
