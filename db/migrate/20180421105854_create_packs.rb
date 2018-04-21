class CreatePacks < ActiveRecord::Migration
  def change
    create_table :packs do |t|
      t.references :user, index: true
      t.integer :kind

      t.timestamps
    end
  end
end
