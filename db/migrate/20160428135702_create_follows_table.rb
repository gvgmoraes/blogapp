class CreateFollowsTable < ActiveRecord::Migration
  def change
  	 create_table :likes do |t|
  		t.integer :user_id
  	end 
  end
end
