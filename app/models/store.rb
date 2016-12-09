class Store < ActiveRecord::Base
  has_many :templates, dependent: :destroy
  has_one :smtp_detail, dependent: :destroy

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
    order_template = templates.create(:email_type_id => EmailType.find_by_name(EmailType::DEFAULT_AVAILABLE[0]).try(:id), :subject => Template::DEFAULT_TEMPLATES[EmailType::DEFAULT_AVAILABLE[0].to_sym][:subject], :body => Template::DEFAULT_TEMPLATES[EmailType::DEFAULT_AVAILABLE[0].to_sym][:body])
    shipment_template = templates.create(:email_type_id => EmailType.find_by_name(EmailType::DEFAULT_AVAILABLE[1]).try(:id), :subject => Template::DEFAULT_TEMPLATES[EmailType::DEFAULT_AVAILABLE[1].to_sym][:subject], :body => Template::DEFAULT_TEMPLATES[EmailType::DEFAULT_AVAILABLE[1].to_sym][:body])
    set_active_template({:email_type_id => order_template.email_type_id, :template_id => order_template.id})
    set_active_template({:email_type_id => shipment_template.email_type_id, :template_id => shipment_template.id})
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
