class CreateFoursquareUsers < ActiveRecord::Migration
  def change
    create_table :foursquare_users do |t|
      t.string :foursquare_id
      t.string :access_token

      t.timestamps
    end
    add_index :foursquare_users, :foursquare_id
  end
end