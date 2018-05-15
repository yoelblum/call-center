class CallCenter

  #Runs over all waiting calls and handles them according to their escalation status
  # nil escalation is handled by a free respondent (if no free respondent it waits to the next poll)
  # 'manager' escalation is handled by a free manager (if no free manager it waits to the next poll)
  # 'director'escalation is handled by a free director (likewise)
  def self.handle_call
      Call.waiting.each do |call|
        if call.escalation.nil?
          free_respondent = Respondent.free.first
          if free_respondent.present?
            free_respondent.handle_call(call)
          end
        elsif call.manager?
          free_manager = Manager.free.first
          if free_manager.present?
            free_manager.handle_call(call)
          end
        elsif call.director?
          free_director = Director.free.first
          if free_director.present?
            free_director.handle_call(call)
          end
        end
      end
  end

  def self.poll_calls
    fork do
      while true
        self.handle_call
        sleep(3)
      end
    end
  end

end
