require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    #array_hashes student => student_info
    # {:name => "Abby Smith", :location}
    students = []

    html = File.read('./fixtures/student-site/index.html')    
    doc = Nokogiri::HTML(html)
    
    #item = doc.css("roster-cards-container") #doesn't work
    items = doc.css("div.roster-cards-container")
    
    cards = items.css("div.student-card")
    #cards = items.css(".student-card")
    
    card_name = cards[0].css('.student-name').text #this works for name
    card_location = cards[0].css(".student-location").text #this works for location
    card_url = cards[0].css("#{.attr('href')}")
    binding.pry

    
    students
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

