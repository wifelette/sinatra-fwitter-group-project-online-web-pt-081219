# frozen_string_literal: true

class UsersController < ApplicationController
  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    # binding.pry
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    # TODO: Investigate this more later
    # We weren't really sure why this didn't work
    # @user = User.new(username: params[:username], password: params[:password], email: params[:email])
    # @user.save

    # session[:user_id] = @user.id
    # redirect to '/tweets'
    if params[:username] == '' || params[:email] == '' || params[:password] == ''
      redirect to '/signup'
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    end
  end

  get '/tweets' do
    erb :"tweets/tweets"
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @tweets = Tweet.all
    erb :'users/show'
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/login'
    end
  end
end
