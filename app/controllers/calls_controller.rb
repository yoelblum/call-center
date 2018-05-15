class CallsController < ActionController::Base
  def create
    Call.create!(status: 0)
  end
end