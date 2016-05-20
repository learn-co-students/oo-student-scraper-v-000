require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    students = doc.css("div.student-card").map.with_index do |student, i|
      name = doc.css("div.student-card div.card-text-container h4.student-name")[i].text
      location = doc.css("div.student-card div.card-text-container p.student-location")[i].text
      url = index_url + doc.css("div.student-card a")[i]["href"]

      {:name => name, :location => location, :profile_url => url}
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

