class CreateClient < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :identifiant, :null => false
      t.text :adresse, :null => false
      t.string :code_postal, :null => true, :length => 20
      t.string :ville, :null => true, :length => 50
      t.string :pays, :null => false, :length => 2
      t.string :email, :null => false, :length => 100
      t.string :status, :null => false, :length => 1
      t.datetime :date_paiement, :null => true
      t.float :prix, :null => false
      t.datetime :date_envoi, :null => true
      t.timestamps
    end

    create_table :article_clients do |t|
      t.integer :article_id, :null => false
      t.integer :client_id, :null => false
      t.integer :quantite, :null => false
      t.float :prix_unitaire, :null => false
    end

    execute "alter table article_clients add constraint fk_article_clients_articles foreign key (article_id) references articles(id)"
    execute "alter table article_clients add constraint fk_article_clients_clientss foreign key (client_id) references clients(id)"
    add_index :clients, :status, :unique => false
    add_index :clients, :date_envoi, :unique => false
    add_index :article_clients, [:article_id, :client_id], :unique => true
  end

  def self.down
    drop_table :article_clients
    drop_table :clients
  end
end
