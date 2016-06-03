require 'open-uri'
# require 'nokogiri'
require 'pry'

# link doc.css(".roster-cards-container .student-card#eric-chu-card a").attribute("href").value
# Name: doc.css(".roster-cards-container .student-card#eric-chu-card .card-text-container h4").text
# Location: doc.css(".roster-cards-container .student-card#eric-chu-card .card-text-container p").text

# puts doc
# puts doc.css(".roster-cards-container")
# puts doc.css(".roster-cards-container .student-card")
# puts doc.css(".roster-cards-container .student-card#eric-chu-card")
# puts doc.css(".roster-cards-container .student-card#eric-chu-card").text
# puts doc.css(".roster-cards-container .student-card").text
# puts doc.css(".roster-cards-container").text
# puts doc.css(".roster-cards-container .student-card#eric-chu-card .card-text-container h4").text


class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_cards = doc.css(".roster-cards-container .student-card")
    hash = student_cards.collect do |student_card|
      {
        :name => student_card.css(".card-text-container h4").text,
        :location => student_card.css(".card-text-container p").text,
        :profile_url => "http://127.0.0.1:4000/" + student_card.css("a").attribute("href").value
      }
    end


  end

  def self.scrape_profile_page(profile_url)

  end

end

# Scraper.scrape_index_page("http://127.0.0.1:4000/")
