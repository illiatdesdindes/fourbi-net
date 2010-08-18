class UselessImageData < ActiveRecord::Migration
  def self.up
    remove_columns :articles, :image_file_size, :image_updated_at
    remove_columns :vues, :image_file_size, :image_updated_at
  end

  def self.down
    add_column :articles, :image_file_size, :integer, :null => true
    add_column :articles, :image_updated_at, :datetime, :null => true
    add_column :vues, :image_file_size, :integer, :null => true
    add_column :vues, :image_updated_at, :datetime, :null => true
  end
end
