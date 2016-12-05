class EmailType < ActiveRecord::Base
  has_many :templates
  DEFAULT_AVAILABLE = ['order', 'shipment']
end
