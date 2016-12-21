class Notifier < ApplicationMailer
  def order_notifier(email_to, email_from, email_subject, body, options)
  options  = {            :delivery_method => :smtp,
                          :address   => 'smtp.gmail.com',
                          :port => 587,
                          :domain => 'localhost:3000',
                          :user_name => 'big.commercedemo123@gmail.com' ,
                          :password  => 'demo1234',
                          :authentication => :plain,
                          :enable_starttls_auto => true ,
                          :return_response => true

          }

  mail(to: email_to, from: 'big.commercedemo123@gmail.com', subject: email_subject, body: body, delivery_method_options: options) do |format|
      format.text { render plain: body }
      format.html { render html: body.html_safe }
  end
  end

  def shipment_notifier(username, email)
    @username = username
    mail(to: email, subject: 'Shipment Created')
  end
end
