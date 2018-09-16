require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
  
    scraped_students = []
    doc.css("div.roster-cards-container").each do |c|
      c.css(".student-card a").each do |s|
      scraped_students << {
        :name => s.css(".student-name").text,
        :location => s.css(".student-location").text,
        :profile_url => s.attr("href")
      }
      end
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    binding.pry
  end

end

