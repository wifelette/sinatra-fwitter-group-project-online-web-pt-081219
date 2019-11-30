# frozen_string_literal: true

ENV['SINATRA_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(ENV['SINATRA_ENV'].to_sym)

# This will allow the Sinatra app to find my `.html.erb` same as `.erb`.
# That matters, because my editor will only help with autocomplete for
# HTML if the file actually has `.html` in it :)
Tilt.register Tilt::ERBTemplate, 'html.erb'

require_all 'app'
