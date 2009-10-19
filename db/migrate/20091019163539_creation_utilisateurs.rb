class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :utilisateurs do |t|
      t.string :login, :null =>false, :limit => 20
      t.string :nom, :null =>false, :limit => 40
      t.string :email, :null =>false, :limit => 40
      t.string :hashed_password, :null =>false
      t.string :salt, :null =>false
      t.boolean :site_admin
      t.timestamps
    end
    add_index :utilisateurs, :login, :unique => true
    add_index :utilisateurs, :nom, :unique => true
  end

  def self.down
    drop_table :utilisateurs
  end
end
