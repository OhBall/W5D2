class ChangeAuthorId < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :author_id, :integer
  end
end
