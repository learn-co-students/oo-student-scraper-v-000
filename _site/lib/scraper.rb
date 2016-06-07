require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
 
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_array =[]
    doc.css(".student-card").each do |card|  
      student_hash = {}
      student_hash =  {
      :name => card.css(".student-name").text,
      :location => card.css(".student-location").text,
      :profile_url => card.css("a").attr('href').text
      }
      student_array << student_hash
    end
    binding.pry
    student_array
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

