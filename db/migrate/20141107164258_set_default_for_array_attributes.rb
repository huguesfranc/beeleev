class SetDefaultForArrayAttributes < ActiveRecord::Migration
  def change
    change_column_default :users, :spoken_languages, []
    change_column_default :users, :expertises, []
    change_column_default :users, :international_activity_countries, []
  end
end
