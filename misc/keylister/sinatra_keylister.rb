require 'sinatra'
require 'json'

SECRET = 'abc123'
# JSON in format {"username":"ssh-rsa ..."}
TEST_KEYS = JSON.load(File.read('keys.json'))

get '/ssh/public-keys' do
  if request.env['HTTP_AUTHORIZATION'] == "Bearer #{SECRET}"
    # the authorization header matched
    output = ""
    TEST_KEYS.each_pair do |username, key|
      output << "environment=\"APP_USER=#{username}\" #{key}\n"
    end
    output
  else
    # the header didn't match
    status 401
    "Unauthorized"
  end
end