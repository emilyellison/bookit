class RemoveZipFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :zip
      end

  def down
    add_column :users, :zip, :string
  end
end
