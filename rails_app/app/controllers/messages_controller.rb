class MessagesController < ApplicationController
  def index
    @messages = Message.all
    @message = Message.new
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.create(message_params)
    respond_to do |format|
      if @message.save
        format.js
      end
    end

  end

  private
    def message_params
      params.require(:message).permit(:body)
    end
end

