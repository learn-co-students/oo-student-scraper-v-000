require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    
    doc = Nokogiri::HTML(open(index_url))
    cards = doc.css(".student-card")
    
    cards.collect { |c| create_student_hash(c) }
    
  end

  def self.scrape_profile_page(profile_url)
    
  end

#private
  
  def self.create_student_hash(student_card)
    name = student_card.css('.student-name').text
    location = student_card.css('.student-location').text
    url = student_card.css("a").attribute("href").value
    { name: name, location: location, profile_url: url}
  end

end

