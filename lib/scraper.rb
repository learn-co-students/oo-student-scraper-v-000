require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_index_page(index_url)
    html = open('fixtures/student-site/index.html')
    doc = Nokogiri::HTML(html)
    school = []
    cards = doc.css("div.roster-cards-container")
    cards.each do |card|
     card.css('.student-card a').each do |student|
       name = student.css('.student-name').text
       location = student.css('.student-location').text
       profile = "#{student.attr('href')}"
       school << {name: name, location: location, profile_url: profile}
     end
   end
   school
 end


  def self.scrape_profile_page(profile_url)

  end

end
