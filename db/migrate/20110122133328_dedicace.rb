class Dedicace < ActiveRecord::Migration
  def self.up
    add_column :clients, :dedicace, :string, :null => true
  end

  def self.down
    remove_column :clients, :dedicace
  end
end
