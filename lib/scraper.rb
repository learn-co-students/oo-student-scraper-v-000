require 'open-uri'
require 'pry'
require "nokogiri"

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    students = []
    page.css("div.roster-cards-container").each do |ind|
      ind.css(".student-card a").each do |student|
        profile= "./fixtures/student-site/#{student.attr('href')}"
        location = student.css('.student-location').text
        name = student.css('.student-name').text
        students << {name: name, location: location, profile_url: profile}
      end
    end
    students
  end

#1) Scraper #scrape_profile_page is a class method
#that scrapes a student's profile page and returns a
#hash of attributes describing an individual student


  def self.scrape_profile_page(profile_url)
    students = {}
    prof = Nokogiri::HTML(open(profile_url))
    social = prof.css(".social-icon-container").children.css("a").map do |soc|
      soc.attribute('href').value
    end
    social.each do |link|
      if link.include?("linkedin")
        students[:linkedin] = link
      elsif link.include?("github")
        students[:github] = link
      elsif link.include?("twitter")
        students[:twitter] = link
      else
        students[:blog] = link
      end
    end
    students[:profile_quote] = prof.css(".profile-quote").text if prof.css(".profile-quote")
    students[:bio] = prof.css("div.bio-content.content-holder div.description-holder p").text if prof.css("div.bio-content.content-holder div.description-holder p")
    students
  end

end
