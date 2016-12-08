class EventType < ActiveRecord::Base
  belongs_to :event
  has_many :templates
end
