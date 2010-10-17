require 'test_helper'

class StumieTest < Test::Unit::TestCase
  def setup
    Stumie.api_key = @key = 'abcdefg'
  end

  def test_pull
    register_response md5('someone@example.com'), '{"foo":"bar"}'

    Stumie.api_key = 'abcdefg'

    assert_equal({ 'foo' => 'bar' }, Stumie.pull('someone@example.com'), "Should return the arguments pulled from stumie")
  end

  def test_404
    register_response md5('foo@example.com'), 'Not found', 404

    assert_nil Stumie.pull('foo@example.com')
  end

  private

  def md5(str)
    Digest::MD5.hexdigest str
  end

  def register_response(id, response, status = 200)
    FakeWeb.register_uri :get, "http://stumie.com/api/profiles/#{id}?key=#{@key}", :body => response, :status => status
  end
end
