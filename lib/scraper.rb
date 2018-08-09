require "nokogiri"
require 'open-uri'
require 'pry'

class Scraper
  

  def self.scrape_index_page(index_url)
    url = './fixtures/student-site/index.html'
    doc = Nokogiri::HTML(open(url))
    
    student_list = []
    student = {}
    
    doc.css(".roster-cards-container").css(".student-card").each do |item|
      student = {}
      
      student[:name] = item.css(".student-name").children.map{|name| name.text}.compact[0]
  
      student[:location] = item.css(".student-location").children.map{|location| location.text}.compact[0]
      
      student[:profile_url] = item.css('a').map { |a| a['href']}.flatten[0] unless item.css('a').nil?
      
      student_list << student
      
    end
   
    student_list
  end
  
    
  

  def self.scrape_profile_page(profile_url)
    
  end

end

