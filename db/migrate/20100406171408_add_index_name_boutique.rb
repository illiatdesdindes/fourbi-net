class AddIndexNameBoutique < ActiveRecord::Migration
  def self.up
    add_index :boutiques, :nom, :unique => true
  end

  def self.down
    remove_index :boutiques, :nom
  end
end

