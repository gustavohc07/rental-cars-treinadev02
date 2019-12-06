class AddRolesToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, :integer, defaul: 0
  end
end
