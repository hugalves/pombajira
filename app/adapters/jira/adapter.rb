module Jira
  class Adapter
    attr_reader :payload

    def initialize(payload)
      @payload = payload
    end

    def process
      request(request_uri)
        .parsed_response
    end

    private

    def request_uri
      "#{jira_uri}#{payload}"
    end

    def request(uri)
      HTTParty
        .get(uri, basic_auth: basic_auth)
    end

    def jira_uri
      "#{site}#{jira_api}"
    end

    def jira_api
      '/rest/api/2'
    end

    def username
      connection_settings[:username]
    end

    def password
      connection_settings[:password]
    end

    def site
      connection_settings[:site]
    end

    def connection_settings
      jira_settings[:connection]
    end

    def jira_settings
      Settings.jira.deep_symbolize_keys
    end

    def basic_auth
      {
        username: username,
        password: password
      }
    end
  end
end
