class NoBoutiqueInUser < ActiveRecord::Migration
  def self.up
    remove_column :utilisateurs, :boutique_id
  end

  def self.down
    add_column :utilisateurs, :boutique_id, :integer, :null => true
  end
end
