class Employee < ApplicationRecord
  enum status: [:free, :busy]
  scope :free, ->{where(status: Employee.statuses['free'])}
  default_scope ->{order('last_active')}

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
  #mock method to handle a call
  #in reality we would probably move this call to a background process
  def _handle(call)
    self.busy!
    call.done!
    self.free!
    self.update(last_active: DateTime.now)
    puts "Call #{call} handled by #{self.attributes}"
  end

end