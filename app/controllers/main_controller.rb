class MainController <  ActionController::Base

  def index
    instance = CallCenter.instance
    render text: instance.redis.get('mykey')
  end

end
