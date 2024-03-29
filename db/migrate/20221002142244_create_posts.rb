class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.integer :genre_id, null: false
      t.integer :count
      t.integer :time
      t.text :body
      t.integer :status, null: false, default: false

      t.timestamps
    end
  end
end
