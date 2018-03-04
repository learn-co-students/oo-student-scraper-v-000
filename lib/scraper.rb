require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card")
    i = 0
    students.collect do |student|
      {:name => student.css(".student-name").text, :location => student.css(".student-location").text, :profile_url => students.css("a")[i]["href"]}
      i += 1
    end
    #binding.pry
  end

  def self.scrape_profile_page(profile_url)
    
  end

end
