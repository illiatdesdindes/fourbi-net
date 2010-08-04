class PaymentMethod < ActiveRecord::Migration
  def self.up
    add_column :clients, :methode_paiement, :string, :limit => 1, :null => true
    execute "update clients set methode_paiement = 'L', status = 'P' where status = 'L'"
    execute "update clients set methode_paiement = 'C', status = 'P' where status = 'C'"
  end

  def self.down
    execute "update clients set status = 'L' where status = 'P' and methode_paiement = 'L'"
    execute "update clients set status = 'C' where status = 'P' and methode_paiement = 'C'"
    remove_column :clients, :methode_paiement
  end
end
