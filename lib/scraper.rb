require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    scraped_students = []
    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        name = student.css('.student-name').text
        location = student.css('.student-location').text
        profile = "#{student.attribute('href')}"
        scraped_students << {name: name, location: location, profile_url: profile}
      end
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    scraped_student = {}
    profile_page = Nokogiri::HTML(open(profile_url))
    social_links = profile_page.css(".social-icon-container").children.css("a").map{ |link| link.attribute('href').value }
    social_links.each do |link|
      if link.include?("linkedin")
        scraped_student[:linkedin] = link
      elsif link.include?("github")
        scraped_student[:github] = link
      elsif link.include?("twitter")
        scraped_student[:twitter] = link
      else
        scraped_student[:blog] = link
      end

      scraped_student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
      scraped_student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")
      end
    scraped_student
  end
end
