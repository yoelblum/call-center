class Call < ApplicationRecord
  belongs_to :employee, optional: true
  enum status: [:waiting, :being_handled, :done]
  enum escalation: [:manager, :director]

  scope :waiting, ->{where(status: Call.statuses[:waiting])}

end