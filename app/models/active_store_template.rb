class ActiveStoreTemplate < ActiveRecord::Base
  belongs_to :store
  belongs_to :email_type
  belongs_to :template
end
