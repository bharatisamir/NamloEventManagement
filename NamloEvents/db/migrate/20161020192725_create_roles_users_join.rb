class CreateRolesUsersJoin < ActiveRecord::Migration[5.0]
  def change
    create_table :roles_users, :id=>false do |t|
      t.integer :user_id
      t.integer :role_id
    end
    add_index :roles_users,["role_id","user_id"]
  end
  def self.down
    drop_table :roles_users
  end
end
