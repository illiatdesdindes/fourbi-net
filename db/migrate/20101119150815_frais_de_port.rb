class FraisDePort < ActiveRecord::Migration
  def self.up
    add_column :clients, :port, :float, :null => false, :default => 0
    execute "update clients set port = 0"
  end

  def self.down
    remove_column :clients, :port
  end
end
