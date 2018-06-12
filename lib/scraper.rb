require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  index_url = "./fixtures/student-site/index.html"


  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    student_cards = doc.css(".student_card")
    student = []
    student_card.collect do |student_card_xml|
      students << {
      :name => student_card_xml.css("h4.student-name").text,
      :location => student_card_xml.css("p.student-location").text,
      :profile_url => "./fixtures/student-site/" + student_card_xml.css("a").attribute("href").value
    }
    end
  end

  def self.scrape_profile_page(profile_url)

  end

end
