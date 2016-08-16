require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_page)

    index = Nokogiri::HTML(open(index_page))

    students = []

    index.css("div.roster-cards-container").each do |roster|
      roster.css(".student-card a").each do |student|
        name = student.css('.student-name').text
        location = student.css('.student-location').text
        profile = "./fixtures/student-site/#{student.attr('href')}"
        students << {name: name, location: location, profile_url: profile}
      end
    end
    students

  end

  def self.scrape_profile_page(profile_page)

    student = {}
    profile = Nokogiri::HTML(open(profile_page))

    social_media = profile.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
    social_media.each do |medium|

      if medium.include?("github")
        student[:github] = medium
      elsif medium.include?("twitter")
        student[:twitter] = medium
      elsif medium.include?("linkedin")
        student[:linkedin] = medium
      else
        student[:blog] = medium
      end

      student[:profile_quote] = profile.css(".profile-quote").text if profile.css(".profile-quote")
      student[:bio] = profile.css("div.bio-content.content-holder div.description-holder p").text if profile.css("div.bio-content.content-holder div.description-holder p")

    end
    student

  end

end
