require 'rubygems'
require 'bundler'

Bundler.setup

require 'test/unit'
require 'fake_web'
require 'stumie'

FakeWeb.allow_net_connect = false
