class CreateHashtags < ActiveRecord::Migration[6.0]
  def change
    create_table :hashtags do |t|
      t.string :value
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
