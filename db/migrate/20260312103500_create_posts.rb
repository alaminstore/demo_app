class CreatePosts < ActiveRecord::Migration[8.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :body, null: false
      t.boolean :published, default: false, null: false
      t.datetime :published_at
      t.integer :views_count, default: 0, null: false
      t.timestamps
    end

    add_index :posts, :published
  end
end
