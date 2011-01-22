class AddBoutiqueControllerName < ActiveRecord::Migration
  def self.up
    add_column :boutiques, :nom_controller, :string, :null => true
    execute "update boutiques set nom_controller = 'desordre' where nom = '#{Boutique::NOM_DESORDRE}'"
    execute "update boutiques set nom_controller = 'terrier' where nom = '#{Boutique::NOM_TERRIER}'"
    change_column :boutiques, :nom_controller, :string, :null => false
  end

  def self.down
    remove_columns :boutiques, :nom_controller
  end
end
