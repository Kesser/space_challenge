require 'sinatra'
require './lib/astronaut_service.rb'
include ERB::Util

set :bind, '0.0.0.0'

get '/' do
  @as = AstronautService.new
  erb :index
end
