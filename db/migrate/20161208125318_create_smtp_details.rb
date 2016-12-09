class CreateSmtpDetails < ActiveRecord::Migration
  def change
    create_table :smtp_details do |t|

      t.references :store, index: true
      t.string :delivery_method
      t.string :address
      t.integer :port
      t.string :domain
      t.string :username
      t.string :password

      t.timestamps null: false
    end
  end
end
