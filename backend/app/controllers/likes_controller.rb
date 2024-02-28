class LikesController < ApplicationController
  before_action :set_like, only: %i[destroy]

  def create
    @like = Like.new(likes_params)

    if @like.save
      @like.tweet.grade += @like.value
      @like.tweet.save
      render json: @like.tweet.grade, status: :created
    else
      @like.errors
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @like.tweet.grade -= @like.value
    @like.tweet.save
    @like.destroy
    render json: @like.tweet.grade
  end

  private

  def set_like
    @like = Like.find(params[:id])
  end

  def likes_params
    params.require(:like).permit(:tweet_id, :user_id, :value)
  end
end
