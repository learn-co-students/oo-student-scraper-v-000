require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    #binding.pry
    doc = Nokogiri::HTML(open(index_url))
    #binding.pry
    scraped_students = []
    doc.css(".student-card").each do|student|
      scraped_students <<{
      :name => student.css("h4").text, :location => student.css("p").text, :profile_url => student.css("a").attr("href").value
    }
       #{name:name, location:location, profile_url:profile_url}
    end
     scraped_students
    end

  def self.scrape_profile_page(profile_url)

  end

end
