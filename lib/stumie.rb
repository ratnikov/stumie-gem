
require 'net/http'
require 'json'
require 'digest/md5'

module Stumie
  extend self

  HOST = "http://stumie.com/api/profiles/%s?key=%s"

  attr_accessor :api_key

  def pull(email)
    md5 = Digest::MD5.hexdigest(email)

    response = Net::HTTP.get_response URI.parse(HOST % [ md5, api_key ])

    response.code =~ /2../ ? parse_json(response.body) : nil
  end

  private

  def parse_json(json)
    JSON.parse json
  end
end
