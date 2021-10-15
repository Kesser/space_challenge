require 'httparty'

class AstronautService

  def initialize
    begin
      response = HTTParty.get("http://api.open-notify.org/astros.json")
      @data = JSON.parse(response.body)
    rescue
      raise "Unable to get or parse json data."
    end
  end

  def get_astronauts
    people_in_space = {}

    @data["people"].each do |person|
      craft_name = person["craft"]
      people_in_space[craft_name] ||= []
      people_in_space[craft_name] << person["name"]
    end
    people_in_space
  end

  def count_astronauts
    @data["number"]
  end

end
