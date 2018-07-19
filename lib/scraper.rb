require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    page = Nokogiri::HTML(open(index_url))
    student_info = page.css(".student-card")
    student_info.each do |student_cards|
      students << {
        :name => student_cards.css("h4.student-name").text,
        :location => student_cards.css("p.student-location").text,
        :profile_url => student_cards.css("a").attribute("href").value
      }
    end
    students
  end


  def self.scrape_profile_page(profile_url)
    attributes = {}
    profile = Nokogiri::HTML(open(profile_url))
    social_media = profile.css(".social-icon-container a").each do |link|
      valid_link = link.attribute("href").value
      attributes[:twitter] = valid_link if valid_link.include?("twitter")
      attributes[:linkedin] = valid_link if valid_link.include?("linkedin")
      attributes[:github] = valid_link if valid_link.include?("github")
      attributes[:blog] = valid_link if link.css(".img").attribute(".src").value.include?("rss")
    end
    attributes[:profile_quote] = profile.css(".profile-quote").text
    attributes[:bio] = profile.css("p").text
    attributes
  end

end
