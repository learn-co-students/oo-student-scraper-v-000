require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        student_url = "http://127.0.0.1:4000/#{student.attr('href')}"
        students << {name: student_name, location: student_location, profile_url: student_url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profiles = {}
    profile_page = Nokogiri::HTML(open(profile_url))
    urls = profile_page.css(".social-icon-container").children.css("a").map {|icon| icon.attribute("href").value}
      urls.each do |url|
        if url.include?("twitter")
          profiles[:twitter] = url
        elsif url.include?("linkedin")
          profiles[:linkedin] = url
        elsif url.include?("github")
          profiles[:github] = url
        else
          profiles[:blog] = url
        end
      end
    profiles[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
    profiles[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")
    profiles
  end
end
