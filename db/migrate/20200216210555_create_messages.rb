class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.bigint :twitter_id
      t.string :author
      t.text :body
      t.datetime :publication_date

      t.timestamps
    end
  end
end
