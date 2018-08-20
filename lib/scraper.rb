require 'open-uri'
require 'pry'
require 'nokogiri'
#all cards: div.roster-cards-container
doc = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
binding.pry
class Scraper


  def self.scrape_index_page(index_url)
    results = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css("div.roster-cards-container").each do |container|
      results << {
        :name => doc.css("div.card-text-container h4").text,
        :location => doc.css("div.card-text-container p").text,
        :profile_url => doc.css("a").value
      }
    end
    results
  end

  def self.scrape_profile_page(profile_url)

  end

end
