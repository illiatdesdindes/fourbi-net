class IndexNouveaute < ActiveRecord::Migration
  def self.up
    add_index :articles, :nouveaute_id, :unique => false
  end

  def self.down
    remove_index :articles, :nouveaute_id
  end
end
