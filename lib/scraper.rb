require 'nokogiri'
require 'open-uri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url))
    profiles = {}
    doc.css(".student-card").collect do |x|
      profiles = { :name => x.css(".card-text-container h4").text,
      :location => x.css(".card-text-container p").text,
      :profile_url => x.css("a").attribute("href").value
    }
    end

  end

    def self.scrape_profile_page(profile_url)
      doc = Nokogiri::HTML(open(profile_url))
      profiles = {}

      doc.css("div.social-icon-container a").each do |link|

        case link.attribute("href").value
          when /twitter/
          profiles[:twitter] = link.attribute("href").value
          when /github/
            profiles[:github] = link.attribute("href").value
          when /linkedin/
          profiles[:linkedin] = link.attribute("href").value
          else
            profiles[:blog] = link.attribute("href").value
        end #case
      end #each method
      profiles[:profile_quote] = doc.css("div.profile-quote").text
      profiles[:bio] = doc.css(".description-holder p").text.strip
      profiles
  end #self.scrape_profile_page

end #scarper class
