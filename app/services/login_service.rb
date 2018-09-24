INDIE_AUTH_ENDPOINT     = 'https://indielogin.com/auth'
INDIE_AUTH_CLIENT_ID    = 'http://localhost:3000'
INDIE_AUTH_REDIRECT_URI = 'http://localhost:3000/session/callback'

class LoginService
  def initialize(user)
    @user = user
  end

  def redirect_uri
    uri = URI.parse(INDIE_AUTH_ENDPOINT)
    uri.query = URI.encode_www_form( params )
    uri.to_s
  end

  def verified?(code)
    uri = URI.parse(INDIE_AUTH_ENDPOINT)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    response = http.post(INDIE_AUTH_ENDPOINT, URI.encode_www_form({
      code: code,
      redirect_uri: INDIE_AUTH_REDIRECT_URI,
      client_id: INDIE_AUTH_CLIENT_ID
    }))

    response_body = JSON.parse(response.body)
    if response.code == "200"
      return true
    else
      raise StandardError.new(response_body['error'] + " - " + response_body['error_description'])
    end
  end

  private

  def params
    @params ||= {
      me: @user.website,
      client_id: INDIE_AUTH_CLIENT_ID,
      redirect_uri: INDIE_AUTH_REDIRECT_URI,
      state: @user.generate_random_state_string
    }
  end
end