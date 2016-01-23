require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    scraped_students = []
     page.css('.student-card').each do |student|
      h = {}
      h[:name] = student.css("h4").text
      h[:location] = student.css("p").text
      h[:profile_url] = student.css("a").attribute("href").value
      scraped_students << h
    end
    scraped_students
  end


  def self.scrape_profile_page(profile_url)
    
  end

end

