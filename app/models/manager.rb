class Manager < Employee
 # belongs_to :director, class_name: :employee, foreign_key: :manager_id
 belongs_to :manager, class_name: 'Director', foreign_key: :manager_id, optional: true

 def escalate(call)
   call.update(escalation: Call.escalations[:director])
 end

end