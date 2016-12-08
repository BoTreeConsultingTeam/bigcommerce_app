class Store < ActiveRecord::Base
  has_many :templates, dependent: :destroy
  has_many :active_store_templates, dependent: :destroy

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
end
