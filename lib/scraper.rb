require 'open-uri'
require 'pry'
require 'nokogiri'
#all cards: div.roster-cards-container
#names: div.card-text-container h4
# doc = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
# binding.pry
class Scraper


  def self.scrape_index_page(index_url)
    results = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css("div.student-card").each do |container|
      results << {
        :name => container.css("h4").text,
        :location => container.css("p").text,
        :profile_url => container.css("a").attribute("href").value
      }
    end
    results
  end

  def self.scrape_profile_page(profile_url)
    
  end

end
