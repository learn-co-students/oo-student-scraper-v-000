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
    hash = {}
    doc = Nokogiri::HTML(open(profile_url))
    doc.css(".social-icon-container a").each do |tag|
      if tag.first[1].include?("twitter")
        hash[:twitter] = tag.first[1]
      end
      if tag.first[1].include?("linkedin")
        hash[:linkedin] = tag.first[1]
      end
      if tag.first[1].include?("github")
        hash[:github] = tag.first[1]
      end
      if !tag.first[1].include?("twitter") && !tag.first[1].include?("linkedin") && !tag.first[1].include?("github")
        hash[:blog] = tag.first[1]
      end
    end

    hash[:profile_quote] = doc.css(".profile-quote").text
    hash[:bio] = doc.css(".description-holder p").text
    hash
  end

end
