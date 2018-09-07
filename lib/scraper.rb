require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").collect { |c| create_student_hash(c) }
  end

  def self.scrape_profile_page(profile_url)
    
    doc = Nokogiri::HTML(open(profile_url))
    urls = doc.css(".social-icon-container").css("a")
    
    { twitter: urls[0].attribute("href").value,
      linkedin: urls[1].attribute("href").value,
      github: urls[2].attribute("href").value,
      blog: urls[3].attribute("href").value,
      profile_quote: doc.css(".profile-quote").text,
      bio: doc.css(".description-holder").css("p").text }
    
  #  twitter_url = doc.css(".social-icon-container").css("a").attribute("href").value
  #  all_url = doc.css(".social-icon-container").css("a")
  #  tu = all_url[0].attribute("href").value
  #  lu = all_url[1].attribute("href").value
 #   gu = all_url[2].attribute("href").value
 #   bu = all_url[3].attribute("href").value
    
 #   profile_quote = doc.css(".profile-quote").text
    
  #  bio = doc.css(".description-holder").css("p").text
    
    
  #  binding.pry
    
  end




#private
  
  def self.create_student_hash(student_card)
    
    { name: student_card.css('.student-name').text,
      location: student_card.css('.student-location').text, 
      profile_url: student_card.css("a").attribute("href").value }
  
  end

end

