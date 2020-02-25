class CreateHashtagsUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :hashtags_users do |t|
      t.integer :user_id
      t.integer :hashtag_id

      t.timestamps
    end
  end
end
