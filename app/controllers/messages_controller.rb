class MessagesController < ApplicationController
  
  before_filter :check_user, only: :new
  
  def index
    @message = Message.new
    @conversations = current_user.all_conversations
  end
  
  def new
    @artists = User.artist
    @message = Message.new
  end
  
  def create
    receiver = User.find_by_email(params[:message][:receiver])
    unless receiver.blank?
      message = Message.create!(sender: current_user, receiver: receiver, content: params[:message][:content])
      Notification.send_message_notifiction(current_user, receiver, message).deliver
      flash[:alert] = "Message sent successfully"
    else
      flash[:notice] = "Email #{params[:message][:receiver]} not in our database. please try again"
    end
    redirect_to messages_path
  end
  
  private

  def check_user
    unless current_user.client?
      flash[:notice] = "You havn't permission to access this page."
      redirect_to root_path 
    end
  end
end