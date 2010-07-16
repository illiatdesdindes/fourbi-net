class CreateVue < ActiveRecord::Migration
  def self.up
    create_table :vues do |t|
      t.integer :article_id, :null => false

      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at

      t.timestamps
    end
    add_index :vues, :article_id, :unique => false
    execute 'alter table vues add constraint fk_vue_article foreign key (article_id) references articles(id)'

  end

  def self.down
    drop_table :vues
  end
end
