class Store < ActiveRecord::Base
  has_many :templates, dependent: :destroy
  has_one :smtp_detail

  def set_active_template(param)
    active_store_templates.where(:email_type_id => param[:email_type_id]).destroy_all
    active_store_templates.create(param)
  end

  def order_templates
    templates.where(:email_type_id => EmailType.find_by_name(EmailType::DEFAULT_AVAILABLE[0]).try(:id))
  end

  def shipment_templates
    templates.where(:email_type_id => EmailType.find_by_name(EmailType::DEFAULT_AVAILABLE[1]).try(:id))
  end

  def set_default_templates_and_activate
    order_template = self.templates.find_or_create_by(::Template::DEFAULT_TEMPLATES[:order])
    shipment_template = self.templates.find_or_create_by(::Template::DEFAULT_TEMPLATES[:shipment])
  end

  def active_order_created_event_template
    event = Event.find_by(name: 'order')
    event_type =  EventType.find_by(name: 'order created')
    templates.where(event_id: event.id, event_type_id: event_type.id, active: true)
  end

  def active_shipment_created_event_template
    event = Event.find_by(name: 'shipment')
    event_type =  EventType.find_by(name: 'shipment created')
    templates.where(event_id: event.id, event_type_id: event_type.id, active: true)
  end
end
