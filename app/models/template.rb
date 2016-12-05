class Template < ActiveRecord::Base
  belongs_to :stroe
  belongs_to :email_type

  validates :subject, :body, presence: true
end
