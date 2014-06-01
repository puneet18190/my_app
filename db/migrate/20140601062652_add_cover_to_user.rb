class AddCoverToUser < ActiveRecord::Migration
  def self.up
    add_attachment :users, :cover
  end

  def self.down
    remove_attachment :users, :cover
  end
end
