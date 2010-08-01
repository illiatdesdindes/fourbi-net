class BillingData < ActiveRecord::Migration
  def self.up
    add_column :clients, :cyberplus_auth_number, :string, :limit => 6, :null => true
    add_column :clients, :cyberplus_auth_result, :string, :limit => 2, :null => true
    add_column :clients, :cyberplus_payment_certificate, :string, :limit => 40, :null => true
    add_column :clients, :cyberplus_result, :string, :limit => 2, :null => true
    add_column :clients, :cyberplus_verification_banque, :boolean, :null => true
  end

  def self.down
    remove_column :clients, :cyberplus_auth_number
    remove_column :clients, :cyberplus_auth_result
    remove_column :clients, :cyberplus_payment_certificate
    remove_column :clients, :cyberplus_result
    remove_column :clients, :cyberplus_verification_banque
  end
end
