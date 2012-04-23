class AddReaderWriterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reader, :boolean, default: false
    add_column :users, :writer, :boolean, default: false
  end
end
