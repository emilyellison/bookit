class CreateBookPosts < ActiveRecord::Migration
  def change
    create_table :book_posts do |t|
      t.string :out_title
      t.string :out_subtitle
      t.string :out_genre
      t.string :out_summary
      t.date :out_date
      t.integer :user_id

      t.timestamps
    end
    add_index :book_posts, [:user_id, :created_at]
  end
end
