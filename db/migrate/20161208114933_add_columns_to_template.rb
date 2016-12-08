class AddColumnsToTemplate < ActiveRecord::Migration
  def change
    add_column :templates, :name, :string
    add_column :templates, :active, :boolean
    add_column :templates, :event_id, :integer
    add_column :templates, :event_type_id, :integer
  end
end
