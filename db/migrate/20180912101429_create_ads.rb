class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :type
      t.references :user, index: true
      t.text :content
      t.string :illustration
      t.string :link
      t.integer :click

      t.timestamps
    end
  end
end
