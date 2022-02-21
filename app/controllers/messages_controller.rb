class MessagesController < ApplicationController
  before_action :find_message, only: [:edit, :update, :destroy]

  def create
    @message = authorize Message.new(message_params)
    @message.user = current_user

    if @message.save
      redirect_to topic_path(@message.topic), notice: 'Votre message a bien été créé.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @message.update(message_params)
      redirect_to topic_path(@message.topic), notice: 'Votre message a bien été modifié.'
    else
      render :edit
    end
  end

  def destroy
    topic = @message.topic
    @message.destroy
    redirect_to topic_path(topic), notice: 'Votre message a bien été supprimé.'
  end

  private

  def find_message
    @message = authorize policy_scope(Message).find(params[:id])
  end

  def message_params
    params.require(:message).permit(:content, :topic_id)
  end
end
