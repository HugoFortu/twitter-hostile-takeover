class TweetsController < ApplicationController

  def index
    p '***************************************************'
    p params
    p tweets_params
    p '/////////////////////////////////////////////////'
  end

  private

  def tweets_params
    params.permit(:content).to_h
  end
end