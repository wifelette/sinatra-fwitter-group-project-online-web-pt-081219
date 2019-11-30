# frozen_string_literal: true

require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/login' do
    erb :'/users/login'
  end

  get '/signup' do
    erb :'/users/create_user'
  end
end
