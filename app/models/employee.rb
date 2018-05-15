class Employee < ApplicationRecord
  has_many :calls
  enum status: [:free, :busy]
  scope :free, ->{where(status: Employee.statuses['free'])}

  def handle_call(call)
    call.update(employee_id: self.id)
    call.being_handled!
    if can_handle?(call)
      _handle(call)
    else
      call.waiting!
      escalate(call)
    end
  end

  def can_handle?(call)
    [true, false].sample
  end

  def _handle(call)
    self.busy!
    call.done!
    self.free!
    puts "Call #{call} handled by #{self.attributes}"
  end

end