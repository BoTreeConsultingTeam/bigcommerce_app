class Template < ActiveRecord::Base
  belongs_to :stroe
  belongs_to :email_type

  validates :subject, :body, presence: true
  paginates_per 10
end
