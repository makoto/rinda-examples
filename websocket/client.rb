require 'rubygems'
require 'sinatra'
require 'json'
require 'erb'

get '/' do
  @wsport = ARGV[0]
  erb :index
end
