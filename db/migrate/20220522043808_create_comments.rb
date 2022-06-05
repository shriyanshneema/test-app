class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :body
      t.references :post, null: false, foreign_key: true
      t.bigint :author_id, null: false, index: true

      t.timestamps
    end
  end
end
