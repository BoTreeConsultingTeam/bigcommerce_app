class Event < ActiveRecord::Base
  has_many :event_types
  has_many :templates
end
