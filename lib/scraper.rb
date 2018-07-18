require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  #name-index_url.css(".student-card a .card-text-container .student-name").text
  #location-index_url.css(".student-card a .card-text-container .student-location").text
  #profile_url-index_url.css(".student-card a")
  #post-index_url.css(".student-card")

  def self.scrape_index_page(index_url)
    index_url= Nokogiri::HTML(open("./fixtures/student-site/index.html"))
    index_url.css(".student-card").map do |profile|
        {name: profile.css("h4.student-name").text,
        location: profile.css("p.student-location").text,
        profile_url: profile.css("a")[0]["href"]
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    #twitter = doc.css(".social-icon-container a")
    doc = Nokogiri::HTML(open(profile_url))
    hash = {}
    doc.css(".social-icon-container a").each do |link|
      href = link.attr('href')
      if href.include?('twitter')
        hash[:twitter] = href
      elsif href.include?('linkedin')
        hash[:linkedin] = href
      elsif href.include?('github')
        hash[:github] = href
      else
        hash[:blog] = href
      end
    end
    p_quote = doc.css(".vitals-text-container .profile-quote").text
    the_bio = doc.css(".details-container .description-holder p").text
    hash[:profile_quote] = p_quote
    hash[:bio] = the_bio
    hash
  end
end
