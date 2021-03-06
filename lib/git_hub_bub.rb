# frozen_string_literal: true

require 'securerandom'
require 'json'
require 'uri'
require 'cgi'

require 'excon'
require 'rrrretry'

require 'git_hub_bub/request'
require 'git_hub_bub/response'

module GitHubBub
  class << self

    def valid_token?(token)
      response = Request.get("https://#{ENV['GITHUB_APP_ID']}:#{ENV['GITHUB_APP_SECRET']}@api.github.com/applications/#{ENV['GITHUB_APP_ID']}/tokens/#{token}", {}, {skip_token: true})
      return response if response.success?
      return false if response.status == 404
    rescue GitHubBub::RequestError => e
      if Request::RAISE_ON_FAIL
        return false
      else
        raise e
      end
    end

    def head(*args)
      Request.head(*args)
    end

    def get(*args)
      Request.get(*args)
    end

    def post(*args)
      Request.post(*args)
    end

    def put(*args)
      Request.put(*args)
    end

    def patch(*args)
      Request.patch(*args)
    end

    def delete(*args)
      Request.delete(*args)
    end
  end
end