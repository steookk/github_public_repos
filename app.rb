# frozen_string_literal: true

require 'sinatra'
require "sinatra/reloader" if development?

require 'active_support/all'
require 'byebug' if development? || test?

require_relative 'search'
require_relative 'search_presenter'

set :port, 3000 if development?

get '/' do
  haml :root
end

get '/search' do
  query = params[:query]
  page = params[:page]&.to_i || 1
  per_page = 100

  search = Search.call(query: query, page: page, per_page: per_page)

  if search.success?
    @presenter = SearchPresenter.new(search)
    haml :search
  else
    search.message
  end
end
