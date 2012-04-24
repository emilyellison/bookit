class ChangeColumnNamesForBookPosts < ActiveRecord::Migration
  def change
    rename_column :book_posts, :out_title, :title
    rename_column :book_posts, :out_subtitle, :subtitle
    rename_column :book_posts, :out_genre, :genre
    rename_column :book_posts, :out_summary, :summary
    rename_column :book_posts, :out_date, :release_date
  end
end
