
require 'net/http'
require 'json'

module Stumie
  extend self

  HOST = "http://stumie.com/api/profiles/%s?key=%s"

  attr_accessor :api_key

  def pull(email)
    md5 = Digest::MD5.hexdigest(email)

    parse_json Net::HTTP.get URI.parse(HOST % [ md5, api_key ])
  end

  private

  def parse_json(json)
    JSON.parse json
  end
end
