class CreateHashtagMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :hashtag_messages do |t|
      t.integer :hashtag_id
      t.integer :message_id

      t.timestamps
    end
  end
end
