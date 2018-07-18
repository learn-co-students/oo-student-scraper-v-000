require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  #name-index_url.css(".student-card a .card-text-container .student-name").text
  #location-index_url.css(".student-card a .card-text-container .student-location").text
  #profile_url-index_url.css(".student-card a")
  #post-index_url.css(".student-card")

  def self.scrape_index_page(index_url)
    doc= Nokogiri::HTML(open(index_url))
    doc.css(".student-card").map do |profile|
      {
        name: profile.css("h4.student-name").text,
        location: profile.css("p.student-location").text,
        profile_url: profile.css("a")[0]["href"]
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    doc.css(".social-icon-container a").each do |link|
      href = link.attr('href')
      if href.include?('twitter')
        student[:twitter] = href
      elsif href.include?('linkedin')
        student[:linkedin] = href
      elsif href.include?('github')
        student[:github] = href
      else
        student[:blog] = href
      end
    end
    student[:profile_quote] = doc.css(".vitals-text-container .profile-quote").text
    student[:bio] = doc.css(".details-container .description-holder p").text
    student
  end
end
