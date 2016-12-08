class ActiveStoreTemplate < ActiveRecord::Base
  attr_accessor :order_template_id, :shipment_template_id
  belongs_to :store
  belongs_to :email_type
  belongs_to :template
end
