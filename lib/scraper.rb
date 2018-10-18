require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    website = Nokogiri::HTML(open(index_url))
    website.css("div.roster-cards-container").each do |cards|
      cards.css(".student-card a").each do |student|
        profile = "#{student.attr('href')}"
        location = student.css('.student-location').text
        name = student.css('.student-name').text
        students << {name: name, location: location, profile_url: profile}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    website = Nokogiri::HTML(open(profile_url))
    websites = website.css("div.social-icon-container").children.css("a").map { |icon| icon.attribute('href').value}
    websites.each do |websites|
      if websites.include?("linkedin")
        student[:linkedin] = websites
      elsif websites.include?("github")
        student[:github] = websites
      elsif websites.include?("twitter")
        student[:twitter] = websites
      else
        student[:blog] = websites
      end
    end

    student[:bio] = website.css("div.bio-content.content-holder div.description-holder p").text 
    student[:profile_quote] = website.css(".profile-quote").text

    student
  end

end
