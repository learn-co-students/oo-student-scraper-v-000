require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))

    students = []

    html.css(".student-card a").each do |student|
      profile = "#{student.attr('href')}"
      location = student.css(".student-location").text
      name = student.css(".student-name").text

      students << {name: name, location: location, profile_url: profile}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))

    students = {}

    social_media_link = profile_page.css(".social-icon-container").children.css("a").map { |el| el.attribute('href').value}
    social_media_link.each do |link|
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
