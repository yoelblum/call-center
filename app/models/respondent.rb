class Respondent < Employee

  belongs_to :manager, class_name: 'Manager'


  def escalate(call)
    call.update(escalation: Call.escalations[:manager])
  end
end