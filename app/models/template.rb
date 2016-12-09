class Template < ActiveRecord::Base
  belongs_to :stroe
  belongs_to :email_type
  has_many :active_store_templates, dependent: :destroy
  belongs_to :event
  belongs_to :event_type
  validates :subject, :body, :event_id, :event_type_id, :name,  presence: true

  paginates_per 20
  DEFAULT_TEMPLATES = {:order => {name: "Default Order Template", active: true, event_id: 1, event_type_id: 1, :subject => "Your Order Placed!!!", :body => "<table style='width:640px;color:rgb(51,51,51);margin:0 auto;border-collapse:collapse' > <tbody> <tr> <td style='padding:0 20px 20px 20px;vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif'> <table style='width:100%;border-collapse:collapse'> <tbody> <tr> <td style='vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif'> <table style='width:100%;border-collapse:collapse'> <tbody> <tr> <td style='width:115px;padding:20px 20px 0 0;vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif' rowspan='2'> <a data-saferedirecturl='http://botreeteststore.mybigcommerce.com/' target='_blank' style='text-decoration:none;color:rgb(0,102,153);font:12px/16px Arial,sans-serif' title='Visit botreeteststore.mybigcommerce.com' href='http://botreeteststore.mybigcommerce.com/'> <img style='border:0;width:115px' src='https://wwwcdn.bigcommerce.com/www1.bigcommerce.com/assets/mediakit/logo-plain.png?mtime=20160412113732' alt='Bigcommerce.com'> </a> </td><td style='text-align:right;padding:5px 0;border-bottom:1px solid rgb(204,204,204);white-space:nowrap;vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif' class='m_-8458387270647573780m_-8456204030309822964m_4722856042003582080m_-5527024756179962845navigation'> </td><td style='width:100%;padding:7px 5px 0;text-align:right;border-bottom:1px solid rgb(204,204,204);white-space:nowrap;vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif'> <a data-saferedirecturl='javascript:;' target='_blank' style='border-right:0px solid rgb(204,204,204);margin-right:0px;padding-right:0px;text-decoration:none;color:rgb(0,102,153);font:12px/16px Arial,sans-serif' href='javascript:;'>Your Orders</a> </td><td style='text-align:right;padding:5px 0;border-bottom:1px solid rgb(204,204,204);white-space:nowrap;vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif'> <span style='text-decoration:none;color:rgb(204,204,204);font-size:15px;font-family:Arial,sans-serif'>&nbsp;|&nbsp;</span> <a data-saferedirecturl='javascript:;' target='_blank' style='border-right:0px solid rgb(204,204,204);margin-right:0px;padding-right:0px;text-decoration:none;color:rgb(0,102,153);font:12px/16px Arial,sans-serif' href='javascript:;'>Your Account</a> <span style='text-decoration:none;color:rgb(204,204,204);font-size:15px;font-family:Arial,sans-serif'>&nbsp;|&nbsp;</span> <a data-saferedirecturl='https://www.bigcommerce.com/' target='_blank' style='border:0;margin:0;padding:0;border-right:0px solid rgb(204,204,204);margin-right:0px;padding-right:0px;text-decoration:none;color:rgb(0,102,153);font:12px/16px Arial,sans-serif' href='https://www.bigcommerce.com/' >BigCommerce.com</a> </td></tr><tr> <td style='text-align:right;padding:7px 0 5px 0;vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif' colspan='3'> <h2 style='font-size:20px;line-height:24px;margin:0;padding:0;font-weight:normal;color:rgb(0,0,0)!important'>Order Confirmation</h2> Order #<span style='color:#000;text-decoration:none;font:12px/16px Arial,sans-serif'>{{order_id}}</span> <br></td></tr></tbody> </table> </td></tr><tr> <td style='vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif'> <table style='width:100%;border-collapse:collapse'> <tbody> <tr> <td style='vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif'> <h3 style='font-size:18px;color:rgb(204,102,0);margin:15px 0 0 0;font-weight:normal'>Hello {{customer_first_name}} {{customer_last_name}},</h3> <p style='margin:0 0 4px 0;font:12px/16px Arial,sans-serif'> Thank you for your order. We’ll send a confirmation when your order ships. </p></td></tr><tr> <td style='vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif'> </td></tr></tbody> </table> </td></tr><tr> <td style='vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif'> <table style='width:100%;border-top:3px solid rgb(45,55,65);border-collapse:collapse'> <tbody> <tr> <td style='font-size:14px;padding:11px 18px 18px 18px;background-color:rgb(239,239,239);width:50%;vertical-align:top;line-height:18px;font-family:Arial,sans-serif'> <p style='margin:2px 0 9px 0;font:14px Arial,sans-serif'> <span style='font-size:14px;color:rgb(102,102,102)'>Arriving:</span><br><b style='color:#009900'> Monday, October 17 - <br>Thursday, October 20 </b> </p><p style='margin:2px 0 9px 0;font:14px Arial,sans-serif'> <span style='font-size:14px;color:rgb(102,102,102)'>Your shipping speed:</span> <br><b> FREE Delivery on eligible orders </b> </p><a data-saferedirecturl='https://store-kddaechy.mybigcommerce.com/account.php?action=order_status' target='_blank' style='font-size:11px;color:rgb(102,102,102);text-decoration:underline;font:12px/16px Arial,sans-serif' href='https://store-kddaechy.mybigcommerce.com/account.php?action=order_status'> <img border='0' style='border:0' src='https://ci5.googleusercontent.com/proxy/KfTShBMmiT22TA_5FwDnQfqjVK9vJHwVH5sEz8IuY-ND--GTuMuGTf8r3weEOwkv4QUdHPOVx1QarN7kzslJ-r43eUvxR3sPB_E7fxt12pgKLdu5uKjzbXI5w0TGITTVQfK6Xg=s0-d-e1-ft#http://g-ecx.images-amazon.com/images/G/01/e-mail/img14/buttons/cta_manage.png' alt='Your Orders' class='CToWUd'> </a> </td><td style='font-size:14px;padding:11px 18px 18px 18px;background-color:rgb(239,239,239);width:50%;vertical-align:top;line-height:18px;font-family:Arial,sans-serif'> <p style='margin:2px 0 9px 0;font:14px Arial,sans-serif'> <span style='font-size:14px;color:rgb(102,102,102)'>Your order will be sent to:</span> <br>{{shipping_address}}</td></tr></tbody> </table> </td></tr><tr> <td style='vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif'> <b>Why a date range?</b> We’re working to get your order to you as soon as possible. We’ll let you know the specific delivery date when your order ships. </td></tr><tr> <td style='border-bottom:1px solid rgb(204,204,204);vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif'> <h3 style='font-size:18px;color:rgb(204,102,0);margin:15px 0 0 0;font-weight:normal'>Order Details</h3> </td></tr><tr> <td style='vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif'> <table style='width:100%;border-collapse:collapse'> <tbody> <tr> <td style='vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif'> Order #<span style='text-decoration:none;color:rgb(0,0,0);font:12px/16px Arial,sans-serif'>{{order_id}}</span> <br><span style='font-size:12px;color:rgb(102,102,102)'>Placed on {{order_created_at}}</span> </td></tr></tbody> </table> </td></tr><tr> <td style='padding-left:32px;vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif'> <table style='width:95%;border-collapse:collapse'> <tbody> {{order_table}} </tbody> </table> </td></tr><tr> <td style='padding-left:32px;vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif'> <table style='width:95%;border-collapse:collapse'> <tbody> <tr> <td style='border-top:1px solid rgb(234,234,234);padding:0 0 16px 0;text-align:right;line-height:18px;vertical-align:top;font-size:13px;font-family:Arial,sans-serif' colspan='2'> </td></tr><tr> <td style='text-align:right;line-height:18px;padding:0 10px 0 0;vertical-align:top;font-size:13px;font-family:Arial,sans-serif'> Item Subtotal: </td><td style='width:120px;text-align:right;line-height:18px;padding:0 10px 0 0;vertical-align:top;font-size:13px;font-family:Arial,sans-serif'> {{order_subtotal}} </td></tr><tr> <td style='text-align:right;line-height:18px;padding:0 10px 0 0;vertical-align:top;font-size:13px;font-family:Arial,sans-serif'> Shipping &amp; Handling: </td><td style='width:120px;text-align:right;line-height:18px;padding:0 10px 0 0;vertical-align:top;font-size:13px;font-family:Arial,sans-serif'> {{order_shipping_charge}} </td></tr><tr> <td style='text-align:right;line-height:18px;padding:0 10px 0 0;vertical-align:top;font-size:13px;font-family:Arial,sans-serif' colspan='2'> <p style='margin:0 0 8px 0;font:12px/16px Arial,sans-serif'></p></td></tr><tr> <td style='text-align:right;line-height:18px;padding:0 10px 0 0;vertical-align:top;font-size:13px;font-family:Arial,sans-serif' colspan='2'> <p style='margin:0 0 8px 0;font:12px/16px Arial,sans-serif'></p></td></tr><tr> <td style='text-align:right;line-height:18px;padding:0 10px 0 0;vertical-align:top;font-size:13px;font-family:Arial,sans-serif' colspan='2'> <p style='margin:0 0 8px 0;font:12px/16px Arial,sans-serif'></p></td></tr><tr> <td style='font-size:14px;font-weight:bold;font:12px/16px Arial,sans-serif;text-align:right;line-height:18px;padding:0 10px 0 0;vertical-align:top;font-family:Arial,sans-serif'> <strong>Order Total:</strong> </td><td style='font-size:14px;font-weight:bold;font:12px/16px Arial,sans-serif;text-align:right;line-height:18px;padding:0 10px 0 0;vertical-align:top;font-family:Arial,sans-serif'> <strong>{{order_total}}</strong> </td></tr><tr> <td style='padding:0 0 16px 0;text-align:right;line-height:18px;vertical-align:top;font-size:13px;font-family:Arial,sans-serif' colspan='2'> </td></tr><tr> <td style='border-top:1px solid rgb(234,234,234);padding:0 0 16px 0;text-align:right;line-height:18px;vertical-align:top;font-size:13px;font-family:Arial,sans-serif' colspan='2'> </td></tr></tbody> </table> </td></tr><tr> <td style='vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif'> <table style='width:100%;border-collapse:collapse'> <tbody> <tr> <td style='vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif'> <p style='margin:0 0 4px 0;font:12px/16px Arial,sans-serif'> Need to make changes to your order? Visit our <a data-saferedirecturl='https://support.bigcommerce.com/' target='_blank' style='text-decoration:none;color:rgb(0,102,153);font:12px/16px Arial,sans-serif' href='https://support.bigcommerce.com/'>Help Page</a> for more information.<br></p></td></tr></tbody> </table> </td></tr><tr> <td style='vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif'> <table style='width:100%;padding:0 0 0 0;border-collapse:none'> <tbody> <tr> <td style='vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif'> <p style='padding:0 0 20px 0;border-bottom:1px solid rgb(234,234,234);margin:10px 0 0 0;font:12px/16px Arial,sans-serif'>Some products have a limited quantity available for purchase. Please see the product’s Detail Page for the available quantity. Any orders which exceed this quantity will be automatically canceled.<br><br>We hope to see you again soon.<br><br><span style='font-size:16px;font-weight:bold'> </span> </p></td></tr></tbody> </table> </td></tr><tr> <td style='vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif'> <table style='border-collapse:collapse'> </table> </td></tr><tr> <td style='vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif'> <table style='width:100%;margin:20px 0 0 0;border-collapse:collapse'> <tbody> <tr> <td style='vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif'> <p style='font-size:10px;color:rgb(102,102,102);line-height:16px;margin:0 0 10px 0;font:10px'> This email was sent from a notification-only address that cannot accept incoming email. Please do not reply to this message. </p></td></tr><tr> </tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>"},
                       :shipment => {name: "Default Order Template", active: true, event_id: 2, event_type_id: 2, :subject => "You Shipment Placed!!!", :body => "<table width='640' cellspacing='0' cellpadding='0' style='font:12px/16px Arial,sans-serif;color:#333;background-color:#fff;margin:0 auto'> <tbody> <tr> <td style='vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif'> <table style='width:100%;border-collapse:collapse'> <tbody> <tr> <td style='width:115px;padding:20px 20px 0 0;vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif' rowspan='2'> <a data-saferedirecturl='http://botreeteststore.mybigcommerce.com/' target='_blank' style='text-decoration:none;color:rgb(0,102,153);font:12px/16px Arial,sans-serif' title='Visit botreeteststore.mybigcommerce.com' href='http://botreeteststore.mybigcommerce.com/'> <img style='border:0;width:115px' src='https://wwwcdn.bigcommerce.com/www1.bigcommerce.com/assets/mediakit/logo-plain.png?mtime=20160412113732' alt='Bigcommerce.com'> </a> </td><td style='text-align:right;padding:5px 0;border-bottom:1px solid rgb(204,204,204);white-space:nowrap;vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif' class='m_-8458387270647573780m_-8456204030309822964m_4722856042003582080m_-5527024756179962845navigation'> </td><td style='width:100%;padding:7px 5px 0;text-align:right;border-bottom:1px solid rgb(204,204,204);white-space:nowrap;vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif'> <a data-saferedirecturl='javascript:;' target='_blank' style='border-right:0px solid rgb(204,204,204);margin-right:0px;padding-right:0px;text-decoration:none;color:rgb(0,102,153);font:12px/16px Arial,sans-serif' href='javascript:;'>Your Orders</a> </td><td style='text-align:right;padding:5px 0;border-bottom:1px solid rgb(204,204,204);white-space:nowrap;vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif'> <span style='text-decoration:none;color:rgb(204,204,204);font-size:15px;font-family:Arial,sans-serif'>&nbsp;|&nbsp;</span> <a data-saferedirecturl='javascript:;' target='_blank' style='border-right:0px solid rgb(204,204,204);margin-right:0px;padding-right:0px;text-decoration:none;color:rgb(0,102,153);font:12px/16px Arial,sans-serif' href='javascript:;'>Your Account</a> <span style='text-decoration:none;color:rgb(204,204,204);font-size:15px;font-family:Arial,sans-serif'>&nbsp;|&nbsp;</span> <a data-saferedirecturl='https://www.bigcommerce.com/' target='_blank' style='border:0;margin:0;padding:0;border-right:0px solid rgb(204,204,204);margin-right:0px;padding-right:0px;text-decoration:none;color:rgb(0,102,153);font:12px/16px Arial,sans-serif' href='https://www.bigcommerce.com/' >BigCommerce.com</a> </td></tr><tr> <td style='text-align:right;padding:7px 0 5px 0;vertical-align:top;font-size:13px;line-height:18px;font-family:Arial,sans-serif' colspan='3'> <h2 style='font-size:20px;line-height:24px;margin:0;padding:0;font-weight:normal;color:rgb(0,0,0)!important'>Order Confirmation</h2> Order #<span style='color:#000;text-decoration:none;font:12px/16px Arial,sans-serif'>{{order_id}}</span> <br></td></tr></tbody> </table> </td></tr><tr> <td style='width:640px' colspan='2'> <p style='font:18px Arial,sans-serif;color:#cc6600;margin:15px 20px 0 20px'>Hello {{customer_first_name}} {{customer_last_name}},</p><p style='margin:4px 20px 18px 20px;width:640px'> We thought you'd like to know that we've dispatched this portion of your order separately to give you quicker service. You won't be charged any extra shipping fees, and the remainder of your order will follow as soon as those items become available. If you need to return an item from this shipment or manage other orders, please visit <a data-saferedirecturl='https://www.google.com/url?hl=en&amp;q=https://www.amazon.in/gp/r.html?C%3D1KXQ0YTGK2GG3%26K%3DAC1H0DB3Q6BF%26R%3D1NXICTSMU7RGK%26T%3DC%26U%3Dhttps%253A%252F%252Fwww.amazon.in%252Fgp%252Fcss%252Fyour-orders-access%252Fref%253Dpe_386221_124255561_pe_194751_29698841_oh_b%26A%3DAWYDGZDSU7DZKEGAJORBW4ZVG90A%26H%3DJIBS1SKEIRGJ4JTIFMKGDZVUIC4A%26ref_%3Dpe_386221_124255561_pe_194751_29698841_oh_b&amp;source=gmail&amp;ust=1481261084986000&amp;usg=AFQjCNHuYTNA8ZmwAVuDIk0WkPmmOOY7Bw' target='_blank' style='color:#006699;text-decoration:none' href='https://www.amazon.in/gp/r.html?C=1KXQ0YTGK2GG3&amp;K=AC1H0DB3Q6BF&amp;R=1NXICTSMU7RGK&amp;T=C&amp;U=https%3A%2F%2Fwww.amazon.in%2Fgp%2Fcss%2Fyour-orders-access%2Fref%3Dpe_386221_124255561_pe_194751_29698841_oh_b&amp;A=AWYDGZDSU7DZKEGAJORBW4ZVG90A&amp;H=JIBS1SKEIRGJ4JTIFMKGDZVUIC4A&amp;ref_=pe_386221_124255561_pe_194751_29698841_oh_b'>Your Orders</a> on Amazon.in. </p></td></tr><tr> <td style='padding:0 20px;width:640px' colspan='2'> <table cellspacing='0' cellpadding='0' style='border-top:3px solid #2d3741;width:640px'> <tbody> <tr> <td valign='top' style='font:14px Arial,san-serif;padding:11px 0 14px 18px;width:280px;background-color:#efefef'> <span style='color:#666'>Arriving: </span> <br><p style='margin:2px 0 9px 0'> <strong style='color:#009900'><span data-term='goog_1654351981' class='aBn' tabindex='0'><span class='aQJ'>Saturday, October 15</span></span></strong> </p><a data-saferedirecturl='https://www.google.com/url?hl=en&amp;q=https://www.amazon.in/gp/r.html?C%3D1KXQ0YTGK2GG3%26K%3DAC1H0DB3Q6BF%26R%3D1NXICTSMU7RGK%26T%3DC%26U%3Dhttps%253A%252F%252Fwww.amazon.in%252Fgp%252Fcss%252Fshiptrack%252Fview.html%252Fref%253Dpe_386221_124255561_pe_194751_29698841_typ%253Fie%253DUTF8%2526addressID%253Dlhjmqqlnllp%2526latestArrivalDate%253D1476541800%2526orderID%253D403-0681653-1444348%2526shipmentDate%253D1476162181%2526orderingShipmentId%253D1266983263106%2526packageId%253D1%26A%3DEMPSWNAHFPHQYWHREPXYFWT6QIOA%26H%3DRAKLQ480EO4XGTAZ9KJDRCYPSLOA%26ref_%3Dpe_386221_124255561_pe_194751_29698841_typ&amp;source=gmail&amp;ust=1481261084986000&amp;usg=AFQjCNGf-HJiU4S59kCQV2B3Ixe8L4U2Mw' target='_blank' href='https://www.amazon.in/gp/r.html?C=1KXQ0YTGK2GG3&amp;K=AC1H0DB3Q6BF&amp;R=1NXICTSMU7RGK&amp;T=C&amp;U=https%3A%2F%2Fwww.amazon.in%2Fgp%2Fcss%2Fshiptrack%2Fview.html%2Fref%3Dpe_386221_124255561_pe_194751_29698841_typ%3Fie%3DUTF8%26addressID%3Dlhjmqqlnllp%26latestArrivalDate%3D1476541800%26orderID%3D403-0681653-1444348%26shipmentDate%3D1476162181%26orderingShipmentId%3D1266983263106%26packageId%3D1&amp;A=EMPSWNAHFPHQYWHREPXYFWT6QIOA&amp;H=RAKLQ480EO4XGTAZ9KJDRCYPSLOA&amp;ref_=pe_386221_124255561_pe_194751_29698841_typ'> <img border='0' src='https://ci4.googleusercontent.com/proxy/LcbH4RBCjC4MqkjLQi_V3mG13evGTHs8BY3VTk4516zfbq855DKkIT07cxPfx4vt1-EQO7jKDE6aO4UP7xtFhvKPjBjgbaziYBIzUXj8961du-P-SyJGqHDAlKqli8z7QDnOoaGGHny1=s0-d-e1-ft#https://images-na.ssl-images-amazon.com/images/G/01/x-locale/cs/te/button-track.png' id='m_8521776616304418064m_5002842050371960406m_-8599834865730584034m_7783002159782884724trackYourPackage' alt='Track your package' class='CToWUd'> </a> <br><a data-saferedirecturl='https://www.google.com/url?hl=en&amp;q=https://www.amazon.in/gp/f.html?C%3D1KXQ0YTGK2GG3%26K%3DAC1H0DB3Q6BF%26R%3D1NXICTSMU7RGK%26T%3DC%26U%3Dhttps%253A%252F%252Fwww.amazon.in%252Fgp%252Fcss%252Forder%252Fstatic-display%252Fget-legal-invoice.html%253ForderId%253D403-0681653-1444348%2526ref_%253Dpe_386221_124255561_pe_194751_29698841_inv%26A%3DOW0MABADGXW1GJZJF3XXMS8G4GIA%26H%3DEPBS0NFXNFW73TUC9QHZGNWQLAEA%26ref_%3Dpe_386221_124255561_pe_194751_29698841_inv&amp;source=gmail&amp;ust=1481261084986000&amp;usg=AFQjCNEDM-23BEHlcJKPZJ4t30Mf8XCQ_w' target='_blank' href='https://www.amazon.in/gp/f.html?C=1KXQ0YTGK2GG3&amp;K=AC1H0DB3Q6BF&amp;R=1NXICTSMU7RGK&amp;T=C&amp;U=https%3A%2F%2Fwww.amazon.in%2Fgp%2Fcss%2Forder%2Fstatic-display%2Fget-legal-invoice.html%3ForderId%3D403-0681653-1444348%26ref_%3Dpe_386221_124255561_pe_194751_29698841_inv&amp;A=OW0MABADGXW1GJZJF3XXMS8G4GIA&amp;H=EPBS0NFXNFW73TUC9QHZGNWQLAEA&amp;ref_=pe_386221_124255561_pe_194751_29698841_inv'> <img src='https://ci3.googleusercontent.com/proxy/xlWgPaex4sFVqUoE1iMnZBkY_R3qxq5HiDd0hXLXeS6PH9-AhhrzoQzg4O_LmYkEmQTtjx2cL5EEnfafNgihRr_nCOGRJMb_pTp_SXejCDxNDj8Umm3Ot3XDEjodQhUtRT8=s0-d-e1-ft#http://g-ec2.images-amazon.com/images/G/01/print_invoice_en._V331619170_.png' id='m_8521776616304418064m_5002842050371960406m_-8599834865730584034m_7783002159782884724printInvoiceButton' alt='Print invoice' class='CToWUd'> </a> </td><td valign='top' style='font:14px Arial,san-serif;padding:11px 18px 14px 18px;width:280px;background-color:#efefef'><span style='color:#666'>Your package was sent to:</span><br><p style='margin:2px 0'> <strong> {{customer_first_name}} {{customer_last_name}} <br>{{shipping_address}} </p></td></tr><tr> <td style='font-size:10px;color:#666;padding:0 10px 20px 10px;line-height:16px;width:640px' colspan='2'> <p style='margin:10px 0 0 0;font:11px/16px Arial,sans-serif;color:#333'> Your package is being shipped by Amazon Transportation Services and the tracking number is 211150635008. Please note that a signature may be required for the delivery of the package. </p></td></tr></tbody> </table> </td></tr><tr> <td style='width:640px' colspan='2'> <p style='font:18px Arial,sans-serif;color:#cc6600;border-bottom:1px solid #ccc;margin:0 20px 3px 20px;padding:0 0 3px 0'> Shipment Details </p></td></tr><tr> <td id='m_8521776616304418064m_5002842050371960406m_-8599834865730584034m_7783002159782884724shipmentDetails' style='padding:16px 40px;width:640px' colspan='2'> <table width='565' cellspacing='0' cellpadding='0'> <tbody> {{order_table}} <tr> <td style='border-top:1px solid rgb(234,234,234);padding:0pt 0pt 16px;width:560px' colspan='3'> &nbsp; </td></tr><tr> <td valign='top' align='right' style='font:12px/18px Arial,sans-serif;padding:0 10px 0 0;color:#333;width:480px' colspan='2'> Item Subtotal: </td><td valign='top' align='right' style='font:12px/18px Arial,sans-serif;color:#333;width:85px'> {{order_subtotal}} </td></tr><tr> <td valign='top' align='right' style='font:12px/18px Arial,sans-serif;padding:0 10px 0 0;color:#333;width:480px' colspan='2'> Shipping &amp; Handling: </td><td valign='top' align='right' style='font:12px/18px Arial,sans-serif;color:#333;width:85px'> {{order_shipping_charge}} </td></tr><tr> <td valign='top' align='right' style='font:14px Arial,sans-serif;padding:10px 10px 10px 0;color:#333;width:480px' colspan='2'> Shipment Total: </td><td valign='top' align='right' style='color:#333;font:14px Arial,sans-serif;padding:10px 0 5px 0;color:#333;width:85px'> <strong> {{order_total}} </strong> </td></tr></tbody> </table> </td></tr><tr> <td style='padding:0 20px 0 20px;line-height:22px;width:640px' colspan='2'> <p style='margin:10px 0;padding:0 0 20px 0;border-bottom:1px solid #eaeaea'>We hope to see you again soon!<br><span style='font:14px Arial,san-serif'> <strong>BigCommerce.com</strong> </span> </p></td></tr><tr> <td style='font-size:10px;color:#666;padding:0 20px 20px 20px;line-height:16px;width:640px' colspan='2'> <p>This email was sent from a notification-only address that cannot accept incoming email. Please do not reply to this message.</p></td></tr></tbody> </table>"}}
  AVAILABLE_TEMPLATE_VARIABLES = ["{{order_id}}", "{{customer_first_name}}", "{{customer_last_name}}", "{{shipping_address}}", "{{order_created_at}}", "{{order_table}}", "{{order_subtotal}}", "{{order_shipping_charge}}", "{{order_total}}"]
end
