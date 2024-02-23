class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ update destroy ]

  def index
    # Tweet.joins(:comments).where('tweets.id = 12')
    tweets = Tweet.all.paginate(page: params[:page], per_page: 20)
    tweet_hash = tweets.map do |tweet|
      image_url = nil
      if tweet.image.attached?
        image_url = rails_blob_url(tweet.image)
      end
      tweet.attributes.merge({ image_url: image_url })
    end
    render json: tweet_hash
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
    params.require(:tweet).permit(:content, :user_id, :grade, :image)
  end
end