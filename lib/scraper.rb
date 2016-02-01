require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper


  def self.scrape_index_page(index_url)
    students = []
    index_page = Nokogiri::HTML(open(index_url))
    index_page.css(".student-card").each do |card|
      students << { 
        name: card.css(".student-name").text,
        location: card.css(".student-location").text,
        profile_url: "http://127.0.0.1:4000/" + card.css("a").attribute("href").value  
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    students = {}
    kickstarter = Nokogiri::HTML(open(profile_url))
    kickstarter.css(".social-icon-container a").each do |page|
      profile = page.attribute("href").value
      students[:twitter] = profile if profile.include?("twitter")
      students[:linkedin] = profile if profile.include?("linkedin")
      students[:github] = profile if profile.include?("github")
      students[:blog] = profile if page.css("img").attribute("src").text.include?("rss")
      students[:profile_quote] = kickstarter.css("div.profile-quote").text
      students[:bio] = kickstarter.css("div.description-holder p").text
    end
    students
  end

end