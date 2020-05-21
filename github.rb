require 'octokit'

class Github
  class << self
    private

    def client
      @client ||= Octokit::Client.new
    end
  end
end