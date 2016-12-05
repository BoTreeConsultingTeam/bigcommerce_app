class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.references :store, index: true
      t.references :email_type, index: true
      t.string :subject
      t.text :body

      t.timestamps null: false
    end
  end
end
