# https://developer.foursquare.com/docs/
class FoursquareClient
  attr_accessor :access_token

  def initialize(access_token)
    @access_token = access_token
  end

  def user_info
    @user_info ||= get('users/self').parsed['response']['user']
  end

  def user_id
    user_info['id']
  end

  def user_name
    [user_info['firstName'], user_info['lastName']].join(' ')
  end

  def oauth2_token
    @oauth2_token ||= OAuth2::AccessToken.from_hash(self.class.oauth2_client, {access_token: access_token}.merge(mode: :query, param_name: 'oauth_token'))
  end

  def get(path, params = {})
    oauth2_token.get(self.class.endpoint + path, params)
  end

  def post(path, params = {})
    oauth2_token.post(self.class.endpoint + path, params)
  end

  def create_checkin_reply(checkin_id, options = {})
    post("checkins/#{checkin_id}/reply", params: options)
  end

	class << self
    def endpoint
      'https://api.foursquare.com/v2/'
    end

    def oauth2_client
      options = {
        authorize_url: 'https://foursquare.com/oauth2/authenticate',
        token_url:     'https://foursquare.com/oauth2/access_token',
        raise_errors:  true,
      }
      OAuth2::Client.new("<%= settings['client_id'] %>", "<%= settings['client_secret'] %>", options)
    end
  end
end