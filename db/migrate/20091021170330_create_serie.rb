class CreateSerie < ActiveRecord::Migration
  def self.up
    create_table :series do |t|
      t.string :nom, :null => false
      t.integer :numero, :null => false
      t.integer :boutique_id, :null => false
      t.boolean :active, :null => false
      t.timestamps
    end
    add_index :series, :boutique_id, :unique => false
    add_index :series, :numero, :unique => false
    add_index :series, :active, :unique => false
    execute 'alter table series add constraint fk_series_boutique foreign key (boutique_id) references boutiques(id)'
  end

  def self.down
    drop_table :series
  end
end
