class CreateBookBites < ActiveRecord::Migration
  def change
    create_table :book_bites do |t|
      t.string :bite
      t.integer :user_id

      t.timestamps
    end
    add_index :book_bites, [:user_id, :created_at]
  end
end
