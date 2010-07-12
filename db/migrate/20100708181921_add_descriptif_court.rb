class AddDescriptifCourt < ActiveRecord::Migration
  def self.up
    add_column :articles, :description_longue, :text , :null => true
    rename_column :articles, :description, :description_courte
  end

  def self.down
    remove_column :articles, :description_longue
    rename_column :articles, :description_courte, :description
  end
end
