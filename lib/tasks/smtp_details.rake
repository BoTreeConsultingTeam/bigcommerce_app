require 'rake'
namespace :smtp_details  do
  task :add, [:store_id, :delivery_method, :address, :port, :domain, :username, :password] => :environment do |t, args|
    SmtpDetail.create( store_id: args['store_id'],
        delivery_method: args['delivery_method'],
        address: args['address'],
        port: args['port'],
        domain: args['domain'],
        username: args['username'],
        password: args['password']
      )
      puts "Details added  >> #{args}"
  end
end
