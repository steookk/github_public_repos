# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest-vcr'
require 'rack/test'
require 'vcr'

require_relative 'app'

settings.environment = :test

VCR.configure do |config|
  config.cassette_library_dir = "vcr_cassettes"
  config.hook_into :webmock
end
MinitestVcr::Spec.configure!

describe 'Integration tests' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe '/' do
    before { get '/' }

    it 'returns 200 OK' do
      assert last_response.ok?
    end
  end

  describe '/search', :vcr do
    describe "initial search" do
      before { get '/search?query=octokit' }

      it 'returns OK' do
        assert last_response.ok?
      end
    end

    describe "search with a specific page, :vcr" do
      before { get '/search?query=octokit&page=2' }

      it 'returns OK' do
        assert last_response.ok?
      end
    end

    describe 'search which generates a GitHub error, :vcr' do
      before { get '/search?query=octokit&page=100' }

      it 'returns OK' do
        assert last_response.ok?
      end

      it 'returns a text explaining the error as it comes from GitHub' do
        assert last_response.body.include?('422')
      end
    end 
  end
end
