require 'open-uri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
     name_container = doc.css("div .roster-cards-container")
     name = doc.css("div .student-card").first.css("h4").text
     name_container.map do |profile|
     puts name
   end
   end



  def self.scrape_profile_page(profile_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
     name = doc.css("div .student-card").first.css("h4").text
     from = doc.css("div .student-card").first.css("p").text
      puts doc
  end

end
