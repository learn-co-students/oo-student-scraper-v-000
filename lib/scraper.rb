require 'open-uri'
require 'nokogiri'
require 'pry'


class Scraper

    #scrape_index_page method is responsible for scraping the index page that lists all of the students
  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []

    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        profile_url = "./fixtures/student-site/#{student.attribute('href').value}"
        location = student.css(".student-location").text
        name = student.css(".student-name").text
        students << {name: name, location: location, profile_url: profile_url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    #scrape_profile_page method is responsible for scraping an individual student's profile page to get further information about that student.
    profile_page = Nokogiri::HTML(open(profile_url))
    student = {}
    social_links = profile_page.css("div.social-icon-container a").map { |link| link["href"] }
    social_links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link
      end
    end
    student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
    student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")
    student
  end
end
 


# Scraper.scrape_profile_page('./fixtures/student-site/index.html')

#students: index_page.css("div.roster-cards-container")
#name: 