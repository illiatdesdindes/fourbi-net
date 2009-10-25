class CreateArticle < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :nom, :null => false
      t.text :description, :null => true
      t.integer :numero, :null => false
      t.integer :serie_id, :null => false
      t.integer :nombre_restant, :null => false
      t.float :prix, :null => false
      t.timestamps
    end
    add_index :articles, :serie_id, :unique => false
    add_index :articles, :numero, :unique => false
    add_index :articles, :nombre_restant, :unique => false
    execute 'alter table articles add constraint fk_article_serie foreign key (serie_id) references series(id)'
  end

  def self.down
    drop_table :articles
  end
end
