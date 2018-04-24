require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
   document = Nokogiri::HTML(html)
   student_hashes = []

   document.css(".student-card").each do |student|
     temp_hash = Hash.new
     temp_hash[:name] = student.css(".student-name").text
     temp_hash[:location] = student.css(".student-location").text
     temp_hash[:profile_url] = student.css("a")[0]["href"]
     student_hashes << temp_hash
      end 
   student_hashes
   #binding.pry
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

