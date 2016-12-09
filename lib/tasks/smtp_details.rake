require 'rake'
namespace :smtp_details  do
  task :add, [:store_hash, :delivery_method, :address, :port, :domain, :username, :password] => :environment do |t, args|
    store = Store.find_by(store_hash: args['store_hash'])
    if store.present?
      SmtpDetail.create( store_id: store.id,
          delivery_method: args['delivery_method'],
          address: args['address'],
          port: args['port'],
          domain: args['domain'],
          username: args['username'],
          password: args['password']
        )
        puts "Details added  >> #{args}"
      else
        puts " Store not found"
      end
  end
end
