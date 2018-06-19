class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :url
      t.string :content
      t.integer :sub_id, null: false
      t.string :author_id, null: false 
    end
    add_index :posts, :title
    add_index :posts, :sub_id
    add_index :posts, :author_id
  end
end
