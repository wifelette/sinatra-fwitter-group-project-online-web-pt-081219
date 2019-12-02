# frozen_string_literal: true

class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      @users = User.all
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if logged_in?
      @tweet = Tweet.new(content: params[:content], user_id: current_user.id)
      if @tweet.content == ''
        redirect to '/tweets/new'
      else
        @tweet.save
        redirect to "/tweets/#{@tweet.id}"
      end
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @users = User.all
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:content] == ''
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      @tweet.content = params[:content]
      @tweet.save
    end

    redirect to "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.delete if @tweet && @tweet.user == current_user
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end
end
