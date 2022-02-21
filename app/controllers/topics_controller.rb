class TopicsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :find_topic, only: [:show, :edit, :update, :destroy]

  def index
    @topics = policy_scope(Topic).order(id: :asc)
  end

  def show; end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user = current_user

    if @topic.save
      redirect_to root_path, notice: "Votre topic intitulé '#{@topic.title}' a bien été créé."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @topic.update(topic_params)
      redirect_to root_path, notice: "Votre topic intitulé '#{@topic.title}' a bien été modifié."
    else
      render :edit
    end
  end

  def destroy
    title = @topic.title
    @topic.destroy
    redirect_to root_path, notice: "Votre topic intitulé '#{title}' a bien été supprimé."
  end

  private

  def find_topic
    @topic = authorize policy_scope(Topic).find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:title, :description)
  end
end
