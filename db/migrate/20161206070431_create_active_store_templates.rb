class CreateActiveStoreTemplates < ActiveRecord::Migration
  def change
    create_table :active_store_templates do |t|

      t.references :store, index: true
      t.references :email_type, index: true
      t.references :template, index: true
      t.timestamps null: false
    end
  end
end
