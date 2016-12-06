# All webhooks generateed from Bigcommerce will be handled over here.
require 'mail'
class HooksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def order_created

    Mail.defaults do
      delivery_method :smtp, {
                    :delivery_method => :smtp,
          :address   => "smtp.sendgrid.net",
                                 :port      => 587,
                               :domain    => "localhost:3000",
                               :user_name => "#{ENV['SENDGRID_USERNAME']}",
                               :password  => "#{ENV['SENDGRID_PASSWORD']}",
                               :authentication => 'plain',
                               :enable_starttls_auto => true }
    end

    mail = Mail.deliver do
      to 'nishantupadhyay@botreetechnologies.com'
      from 'big.commercedemo123@gmail.com'
      subject 'This is the subject of your email'
      text_part do
        body 'Hello world in text'
      end
      html_part do
        content_type 'text/html; charset=UTF-8'
        body '<b>Hello world in HTML</b>'
      end
    end

    # write code to handle logic after webhook of order is called
    render nothing: true, status: 200
  end

  def shipment_created
    # write code to handle logic after webhook of shipment creation is called
    render nothing: true, status: 200
  end
end
