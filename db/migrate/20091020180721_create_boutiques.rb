class CreateBoutiques < ActiveRecord::Migration
  def self.up
    create_table :boutiques do |t|
      t.string :nom, :null => false
      t.integer :numero, :null => false
      t.timestamps
    end
    add_index :boutiques, :numero, :unique => true
    add_column :utilisateurs, :boutique_id, :integer, :null => true
    execute 'alter table utilisateurs add constraint fk_utilisateurs_boutique foreign key (boutique_id) references boutiques(id)'
    execute 'insert into boutiques (nom, numero, created_at) values (\'desordre.net\', 0, CURRENT_TIMESTAMP)'
    execute 'insert into boutiques (nom, numero, created_at) values (\'le-terrier.net\', 1, CURRENT_TIMESTAMP)'
  end

  def self.down
    remove_column :utilisateurs, :boutique_id
    drop_table :boutiques
  end
end
