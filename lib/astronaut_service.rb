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
    people_in_space.each do |craft_name, people|
      people_in_space[craft_name] = people.sort {|person1, person2|
        last_name1 = get_last_name(person1)
        last_name2 = get_last_name(person2)
        last_name1 <=> last_name2
      }
    end
    people_in_space
  end

  def get_last_name(name)
    names = name.split(' ')
    return '' if names.length == 1
    return names.last if names.length == 2
    return names[1..names.length].join(' ') if names.length >= 3
  end


  def count_astronauts
    @data["number"]
  end

end
