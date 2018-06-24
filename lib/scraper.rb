require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
      student_scraper = Nokogiri::HTML(open(index_url))
      student = []
      student_scraper.css("div.roster-cards-container").each do |info|
        info.css(".student-card a").each do |link|
          name = link.css(".student-name").text
          location = link.css(".student-location").text
          profile_url = "#{link.attr("href")}"
          student << {:name => name, :location => location, :profile_url => profile_url}
        end
      end
      student
  end

  def self.scrape_profile_page(profile_url)
    student_profile = Nokogiri::HTML(open(profile_url))
    profile = {}
    links = student_profile.css(".social-icon-container").children.css("a").map { |info| info.attribute("href").value}
    links.each do |link|
        if link.include?("linkedin")
          profile[:linkedin] = link
        elsif link.include?("github")
          profile[:github] = link
        elsif link.include?("twitter")
          profile[:twitter] = link
        else
          profile[:blog] = link
    end
  end
    profile[:profile_quote] = student_profile.css(".profile-quote").text if student_profile.css(".profile-quote")
    profile[:bio] = student_profile.css("div.bio-content.content-holder div.description-holder p").text if student_profile.css("div.bio-content.content-holder div.description-holder p")

    profile
    end
  end
