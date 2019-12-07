require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))
    # name = doc.css(".roster-cards-container").css(".student-name")
    # location = doc.css(".roster-cards-container").css(".student-location")
    # profile_url = doc.css(".roster-cards-container").css("div.student-card a").map { |link| link['href']}
    # profile = doc.css(".roster-cards-container").css(".student-card a").map { |link| link['href']}

    doc.collect do |name, location, profile|
      name = doc.css(".roster-cards-container").css(".student-name").text
      location = doc.css(".roster-cards-container").css(".student-location")
      profile = doc.css(".roster-cards-container").css(".student-card a").map { |link| link['href']}

      hash = { :name => name, :location => location, :profile => profile }
      hash
      # Hash.new { |hash, key| hash[key] =  }
      # { hash[name] => name }
      binding.pry
    end
      # binding.pry
    # {"name:" name, "location:" location, "profile_url:" profile_url}
    # {:name => "Abby Smith", :location => "Brooklyn, NY", :profile_url => "students/abby-smith.html"}
    # hash = {}

    # hash = Hash[array.collect { |key, value| [name, name.css(".student-name")] }
    # hash = Hash[*array.flatten]
    # hash = Hash[array.map {|key, value| [name, name.css(".student-name")]}]
    # a3 = [ ['apple', 1], ['banana', 2], [['orange','seedless'], 3] ]
    # h3 = Hash[*a3.flatten]


    end

  # end

  def self.scrape_profile_page(profile_url)

  end

end
