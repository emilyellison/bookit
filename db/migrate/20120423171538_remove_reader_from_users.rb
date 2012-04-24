class RemoveReaderFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :reader
      end

  def down
    add_column :users, :reader, :boolean
  end
end
