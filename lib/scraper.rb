require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    student_list = []
    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card").each do |person|
        person_name = person.css(".student-name").text
        person_location = person.css(".student-location").text
        person_profile_url = person.css("a").attribute("href").value
        student_list << {name: person_name, location: person_location, profile_url: person_profile_url}
      end
    end
    student_list
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student = {}
    profile_page.css(".social-icon-container a").each do |detail|
      social_link = detail.attr("href")
      if social_link.include?("twitter")
        student[:twitter] = social_link
      elsif social_link.include?("linkedin")
        student[:linkedin] = social_link
      elsif social_link.include?("github")
        student[:github] = social_link
      else
        student[:blog] = social_link
      end
    end
    student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text
    student[:profile_quote] = profile_page.css(".profile-quote").text
    student
  end

end
