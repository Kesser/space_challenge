ENV['APP_ENV'] = 'test'

require './lib/astronaut_service.rb'
require 'rspec'
require 'rack/test'

RSpec.describe AstronautService do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "downloads data from space api" do
    allow(HTTParty).to receive(:get).and_return(Object.new)
    allow_any_instance_of(Object).to receive(:body).and_return("{}")
    allow(JSON).to receive(:parse).with(any_args)

    AstronautService.new

    expect(HTTParty).to have_received(:get)
    expect(JSON).to have_received(:parse)
  end

  it "#get_astronauts" do
    as = AstronautService.new
    data = as.get_astronauts
    expect(data).to be_kind_of(Hash)
  end

  it "#count_astronauts" do
    as = AstronautService.new
    expect(as.count_astronauts).to be 10
  end
end
