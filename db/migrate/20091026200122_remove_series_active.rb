class RemoveSeriesActive < ActiveRecord::Migration
  def self.up
    remove_column :series, :active
  end

  def self.down
    add_column :series, :active, :boolean, :null => true
    execute 'update series set active = true'
    change_column :series, :active, :boolean, :null => false
  end
end
