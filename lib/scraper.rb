require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").map do |student|
      {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.children[1].attributes["href"].value 
      }
  end
end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile = {}
    profile[:bio] = doc.css(".description-holder")[0].text.strip
    profile[:profile_quote] = doc.css(".profile-quote").text
    counter = 1
    media = doc.css(".social-icon-container")[0].children
    while(counter < media.length)
      sm = media[counter].attributes["href"].value
      case sm.gsub(/https:\/\/|www./, "").split(".")[0]
        when "twitter"
          profile[:twitter] = sm
        when "linkedin"
          profile[:linkedin] = sm
        when "github"
          profile[:github] = sm
        when "youtube"
          profile[:youtube] = sm
        else
          profile[:blog] = sm
      end
      counter += 2
    end
    profile
  end

end

