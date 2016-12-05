class AddUserDetailsToStore < ActiveRecord::Migration
  def change
    add_column :stores, :username, :string
    add_column :stores, :email, :string
  end
end
