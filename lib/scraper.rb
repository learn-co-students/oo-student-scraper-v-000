require 'open-uri'
require 'nokogiri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    
    students = []
    
    doc = Nokogiri::HTML(open(index_url))
     
    doc.css("div.roster-cards-container").each do |card|
      card.css().each do |student_card|
      
        student = {}
        student[:name] = nil
      end
      puts "#{card}"
      binding.pry
   
    end
    
  end
    
end   
    
                   
  
 



