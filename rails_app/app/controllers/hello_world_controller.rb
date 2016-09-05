class HelloWorldController < ApplicationController
  def index #hello_world
    Pusher.trigger('test_channel', 'my_event', {
      message: 'hello world'
    })
  end
end

