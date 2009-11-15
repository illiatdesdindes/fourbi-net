class AjoutDescriptif < ActiveRecord::Migration
  def self.up
    add_column :boutiques, :description, :text , :null => true
    add_column :series, :description, :text , :null => true
  end

  def self.down
    remove_column :boutiques, :description
    remove_column :series, :description
  end
end
