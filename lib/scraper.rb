require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  
  
  def self.scrape_index_page(index_url)
    student_index_hash = []
    
    doc = Nokogiri::HTML(open(index_url="./fixtures/student-site/index.html"))
    
    cards = doc.css(".student-card")
    cards.each do |card|
      student_hash = {
      :name => card.css(".student-name").text,
      :location =>  card.css(".student-location").text,
      :profile_url => card.css("a").attribute("href").text
      }

      student_index_hash << student_hash
    end
    student_index_hash
  end
  

  
  def self.scrape_profile_page(profile_url="./fixtures/student-site/students/joe-burgess.html")
    
    scraped_student = {}
    doc = Nokogiri::HTML(open(profile_url))
   
    l = doc.css(".social-icon-container a").collect do |link| 
      url = link['href']
      url_name = url.split("/")[2]
      url_name = url_name.gsub("www.","")
      
      case url_name
      when "twitter.com"
      scraped_student[:twitter]= url
      when "linkedin.com"
      scraped_student[:linkedin]= url
      when "github.com"
      scraped_student[:github]= url
      else
      scraped_student[:blog]= url
      end
    end

    scraped_student[:profile_quote]= doc.css(".profile-quote").text
    scraped_student[:bio]= doc.css(".details-container").css(".description-holder p").text
    
    scraped_student
  end
end
  
  
  

    
  


# test = Scraper.new 
# test.scrape_index_page
# test.scrape_profile_page

