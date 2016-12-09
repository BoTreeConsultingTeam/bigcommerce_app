NAMES = ['order', 'shipment']
NAMES.each do |name|
  Event.find_or_create_by(name: name)
end

Event.where(name: 'order').first.event_types.find_or_create_by(name: 'order created')
Event.where(name: 'shipment').first.event_types.find_or_create_by(name: 'shipment created')
