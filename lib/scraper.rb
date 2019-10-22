
require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    info = []
    page = Nokogiri::HTML(open(index_url))
    student = page.css(".student-card")
    student.each do |card|
      info << {:name => card.css("h4").text, :location => card.css("p").text, :profile_url => card.css("a")[0]["href"]}
    end
    info
  end

  def self.scrape_profile_page(profile_url)
    page = {}
    profile = Nokogiri::HTML(open(profile_url))
    social = profile.css(".social-icon-container a")
    social.each do |link|
      link = link.attribute("href").value
      if link.include?("twitter")
        page[:twitter] = link
      elsif link.include?("linkedin")
       page[:linkedin] = link
      elsif link.include?("github")
       page[:github] = link
      else
       page[:blog] = link
      end
    end
    page[:profile_quote] = profile.css(".profile-quote").text if profile.css(".profile-quote")
    page[:bio] = profile.css(".description-holder p").text
    page
  end

end
