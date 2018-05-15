class Director < Employee
  def can_handle?(call)
    true
  end
end