require "rails_helper"

RSpec.describe CallCenter do
  before(:each) do
    @director = Director.create!(name: 'director', status: 'free')
    @manager = Manager.create!(name: 'manager', manager_id: @director, status: 'free')
    @respondent = Respondent.create!(name: 'employee', manager: @manager, status: 'free')
    @call = Call.create!(escalation: nil, status: 0)
  end

  context "not escalated" do
    context "free respondent" do
      it 'if respondent is free and can handle call he will handle the call' do
        expect_any_instance_of(Employee).to receive(:can_handle?).and_return(true)
        CallCenter.handle_call
        expect(@call.reload.status).to be_eql('done')
        expect(@call.employee_id).to be_eql(@respondent.id)
      end

      it 'if employee is free but cannot handle call it is escalated to manager' do
        expect_any_instance_of(Employee).to receive(:can_handle?).and_return(false)
        CallCenter.handle_call
        expect(@call.reload.status).to be_eql('waiting')
        expect(@call.escalation).to be_eql('manager')
      end
    end

    context "no free respondent" do
      it 'call will remain waiting' do
        @respondent.busy!
        CallCenter.handle_call
        expect(@call.reload.status).to be_eql('waiting')
        expect(@call.escalation).to be_nil
      end
    end
  end


  context "escalated to manager" do
    before(:each) do
      @call.manager!
    end

    context "free manager" do
      it 'if manager can handle call he handles it' do
        expect_any_instance_of(Manager).to receive(:can_handle?).and_return(true)
        CallCenter.handle_call
        expect(@call.reload.status).to be_eql('done')
        expect(@call.employee_id).to be_eql(@manager.id)
      end

      it 'if manager cant handle call it is escalated to director' do
        expect_any_instance_of(Manager).to receive(:can_handle?).and_return(false)
        CallCenter.handle_call
        expect(@call.reload.status).to be_eql('waiting')
        expect(@call.director?).to be_truthy
      end
    end
  end

  context "escalated to director" do
    before(:each) do
      @call.director!
    end

    context "free director" do
      it 'is handled by director' do
        CallCenter.handle_call
        expect(@call.reload.status).to be_eql('done')
      end
    end

    context "unfree director" do
      it 'remains waiting for director' do
        @director.busy!
        CallCenter.handle_call
        expect(@call.reload.status).to be_eql('waiting')
      end
    end
  end
end