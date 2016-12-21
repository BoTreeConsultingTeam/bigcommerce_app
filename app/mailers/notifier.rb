class Notifier < ApplicationMailer
  def mail_notifier(email_to, email_from, email_subject, body, options)
  opts  = { :delivery_method => options[:delivery_method],
                :address   => options[:address],
                :port => options[:port],
                :domain => options[:domain],
                :user_name => options[:user_name] ,
                :password  => options[:password],
                :authentication => :plain,
                :enable_starttls_auto => true ,
                :return_response => true
         }
    mail(to: email_to, from: email_from, subject: email_subject, body: body, delivery_method_options: opts) do |format|
        format.text { render plain: body }
        format.html { render html: body.html_safe }
    end
  end
end
