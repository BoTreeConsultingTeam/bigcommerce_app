# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Set all the default available email types for triggring with the application.
EmailType::DEFAULT_AVAILABLE.each{ |type| EmailType.find_or_create_by(:name => type) }
names = ['order', 'shipment']
names.each do |name|
  Event.find_or_create_by(name: name)
end

Event.where(name: 'order').first.event_types.find_or_create_by(name: 'order created')
Event.where(name: 'shipment').first.event_types.find_or_create_by(name: 'shipment created')
