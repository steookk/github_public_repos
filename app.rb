# frozen_string_literal: true

require 'sinatra'
require "sinatra/reloader" if development?

require 'active_support/all'
require 'byebug' if development? || test?

set :port, 3000 if development?

get '/' do
  "Hi Adjust!"
end
