require 'test_helper'

class StumieTest < Test::Unit::TestCase
  def test_pull
    email = 'someone@example.com'

    register_response 'abcdefg', Digest::MD5.hexdigest(email), '{"foo":"bar"}'

    Stumie.api_key = 'abcdefg'

    assert_equal({ 'foo' => 'bar' }, Stumie.pull(email), "Should return the arguments pulled from stumie")
  end

  private

  def register_response(key, id, response)
    FakeWeb.register_uri :get, "http://stumie.com/api/profiles/#{id}?key=#{key}", :body => response, :status => 200
  end
end
