class AddNewArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :nouveaute_id, :integer, :null => true
  end

  def self.down
    remove_columns :articles, :nouveaute_id
  end
end
