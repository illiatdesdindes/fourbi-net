class ParamsCyberplus < ActiveRecord::Migration

  COLUMNS =     {:cyberplus_auth_mode => 10,
                 :cyberplus_card_number => 19,
                 :cyberplus_extra_result => 2,
                 :cyberplus_warranty_result => 20}

  def self.up
    COLUMNS.each_pair do |k, v|
      add_column :clients, k, :string, :null => true, :limit => v
    end
  end

  def self.down
    COLUMNS.each_key do |k|
      remove_column :clients, k
    end
  end
end
