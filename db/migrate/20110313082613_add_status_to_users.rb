class AddStatusToUsers < ActiveRecord::Migration
  def self.up
	change_table :users do |t|
      t.boolean :status, :default => false
  	end
    	User.update_all ["status = ?", true]

  end

  def self.down
    remove_column :users, :status
  end
end
