class AddDescriptifCourt < ActiveRecord::Migration
  def self.up
    add_column :articles, :description_courte, :text , :null => true
    rename_column :articles, :description, :description_longue
  end

  def self.down
    remove_column :articles, :description_courte
    rename_column :articles, :description_longue, :description
  end
end
