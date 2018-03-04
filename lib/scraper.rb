require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card")
    students.collect do |student|
      {:name => student.css(".student-name").text, :location => student.css(".student-location").text, :profile_url => students.css("a")[0]["href"]}
    end
    #binding.pry
  end

  def self.scrape_profile_page(profile_url)
    
  end

end
