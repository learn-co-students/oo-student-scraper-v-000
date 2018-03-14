require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.roster-cards-container").each do |container|
      container.css(".student-card a").each do |student|
        profile_url = "./fixtures/student-site/#{student.attr('href')}"
        profile_location = student.css('.student-location').text
        profile_name = student.css('.student-name').text
        students << {name: profile_name, location: profile_location, profile_url: profile_url }
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    doc = Nokogiri::HTML(open(profile_url))
    social = doc.css(".social-icon-container").children.css("a").map { |i| i.attribute('href').value }
    social.each do |media|
      if media.include?("linkedin")
        student[:linkedin] = media
      elsif media.include?("github")
        student[:github] = media
      elsif media.include?("twitter")
        student[:twitter] = media
      else
        student[:blog] = media
      end
    end
    student[:profile_quote] = doc.css(".profile-quote").text if doc.css(".profile-quote")
    student[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text if doc.css("div.bio-content.content-holder div.description-holder p")
    student
  end
end
