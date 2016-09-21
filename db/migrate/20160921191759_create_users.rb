class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :uid
      t.string :display_name
      t.string :password_digest
      t.string :email
      t.string :top_tracks
      t.string :top_artists
      t.string :hash

      t.timestamps null: false
    end
  end
end
