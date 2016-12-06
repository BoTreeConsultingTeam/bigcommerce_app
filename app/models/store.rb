class Store < ActiveRecord::Base
  has_many :templates, dependent: :destroy
  has_many :active_store_templates, dependent: :destroy

  def set_active_template(param)
    active_store_templates.where(param).first.destroy rescue nil
    active_store_templates.create(param)
  end

  def order_templates
    templates.where(:email_type_id => 1)
  end

  def shipment_templates
    templates.where(:email_type_id => 2)
  end
end
