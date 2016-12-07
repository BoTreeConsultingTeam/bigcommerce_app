# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Set all the default available email types for triggring with the application.
EmailType::DEFAULT_AVAILABLE.each{ |type| EmailType.find_or_create_by(:name => type) }

Template.find_or_creat(subject: 'Notify  customer %%USERNAME%%', body: '<h1>Greetings, %USERNAME%</h1><p>Your order with id: %%ORDER_ID%% is dispatched</p><br></hr><p>Thanks team Botree</p>')
