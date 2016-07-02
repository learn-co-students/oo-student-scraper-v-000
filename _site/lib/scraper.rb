require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  
  def self.scrape_index_page(index_url)
    home_page = Nokogiri::HTML(open(index_url))
    individual_students = []
    
    home_page.css(".student-card").each do |each_card|
      each_card_hash = {
        :name => each_card.css(".student-name").text,
        :location => each_card.css(".student-location").text,
        :profile_url => "http://127.0.0.1:4000/" + each_card.css("a").attribute("href").value
      }
      individual_students << each_card_hash
    end
    individual_students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    
    profile_hash = {}

    profile_page.css(".social-icon-container a").each do |each_link|
      url = each_link.attribute("href").value
      if url.include?("twitter")
        profile_hash[:twitter] = url
      elsif url.include?("linkedin")
        profile_hash[:linkedin] = url
      elsif url.include?("github")
        profile_hash[:github] = url
      else
        profile_hash[:blog] = url
      end
      profile_hash[:profile_quote] = profile_page.css(".vitals-text-container .profile-quote").text
      profile_hash[:bio] = profile_page.css(".description-holder p").text
    end
    profile_hash
  end
end