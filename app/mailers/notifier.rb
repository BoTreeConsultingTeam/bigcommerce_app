class Notifier < ApplicationMailer
  default from: 'big.commerce123@gmail.com'
  def order_notifier(username, email)
    @username = username
    mail(to: email, subject: 'Order Created')
  end

  def shipment_notifier(username, email)
    @username = username
    mail(to: email, subject: 'Shipment Created')
  end
end
