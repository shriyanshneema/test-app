class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :description
      t.integer :tag
      t.integer :comments_count, default: 0
      t.bigint :author_id, null: false, index: true

      t.timestamps
    end
  end
end
