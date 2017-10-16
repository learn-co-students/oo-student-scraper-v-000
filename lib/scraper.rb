require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    result = []
     doc = Nokogiri::HTML(open(index_url))
     doc.css(".student-card").each do |tag|
       hash = {:name => tag.css("h4").text,
              :location => tag.css("p").text,
              :profile_url => tag.at_css("a").first[1]}
       result << hash
     end
     result
  end

  def self.scrape_profile_page(profile_url)

  end

end
