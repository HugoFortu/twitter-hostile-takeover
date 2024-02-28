class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[update destroy]

  def index
    tweets_per_page = 5.0
    tweets = Tweet.order(created_at: :desc).paginate(page: params[:page], per_page: tweets_per_page)
    total_pages = ((Tweet.count / tweets_per_page) + 1).ceil
    tweet_hash = tweets.map do |tweet|
      image_url = nil
      if tweet.image.attached?
        image_url = rails_blob_url(tweet.image)
      end
      tweet = tweet.to_complete_hash
      tweet.merge({ image_url: image_url })
    end
    render json: { data: tweet_hash, total: total_pages }
  end

  def user_tweets
    tweets_per_page = 5.0
    tweets = Tweet.where(user_id: params[:user_id]).order(created_at: :desc).paginate(page: params[:page], per_page: tweets_per_page)
    total_pages = ((Tweet.where(user_id: params[:user_id]).count / tweets_per_page) + 1).ceil
    tweet_hash = tweets.map do |tweet|
      image_url = nil
      if tweet.image.attached?
        image_url = rails_blob_url(tweet.image)
      end
      tweet = tweet.to_complete_hash
      tweet.merge({ image_url: image_url })
    end
    render json: { data: tweet_hash, total: total_pages }
  end

  def create
    @tweet = Tweet.new(tweets_params)
    @tweet.image.attach(tweets_params[:image])
    if @tweet.save
      render json: @tweet, status: :created, location: @tweet
    else
      @tweet.errors
      render json: @tweet.errors, status: :unprocessable_entity
    end
  end

  def update
    if tweets_params[:image]
      @tweet.image.purge
      @tweet.image.attach(tweets_params[:image])
    end
    if @tweet.update(tweets_params)
      render json: @tweet
    else
      render json: @tweet.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @tweet.destroy
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweets_params
    params.require(:tweet).permit(:content, :user_id, :image)
  end
end
