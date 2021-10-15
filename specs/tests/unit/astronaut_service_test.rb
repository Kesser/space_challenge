ENV['APP_ENV'] = 'test'

require './lib/astronaut_service.rb'
require 'rspec'
require 'rack/test'

RSpec.describe AstronautService do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "downloads data" do
    as = AstronautService.new
    expect(as.count_astronauts).to be 10
  end
end
