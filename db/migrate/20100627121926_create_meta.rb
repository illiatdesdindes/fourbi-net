class CreateMeta < ActiveRecord::Migration
  def self.up

    create_table :metas do |t|
      t.string :nom, :null => false
      t.text :contenu, :null =>false
    end
    add_index :metas, :nom, :unique => true

  end

  def self.down
    drop_table :metas
  end

end
