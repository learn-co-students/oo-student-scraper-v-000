require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css("div.roster-cards-container").each do |profile|
      profile.css(".student-card a").each do |student|
        profile_link = "#{student.attr('href')}"
        profile_location = student.css(".student-location").text
        profile_name = student.css(".student-name").text
        students << {name: profile_name, location: profile_location, profile_url: profile_link}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    students = {}
    profile_page = Nokogiri::HTML(open(profile_url))

    links = profile_page.css(".social-icon-container").children.css("a").map { |element| element.attribute('href').value}

    links.each do |link|
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
    students[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
    students[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")
    students
  end
end
