require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_students = []
    index_page = Nokogiri::HTML(open(index_url))
    index_page.css("div.student-card").each do |student|
      name = student.css("h4").text
      location = student.css("p").text
      profile_url = student.css("a").attribute("href").value
      scraped_students << {name: name, location: location, profile_url: profile_url}
      end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    content = {}
    profile_page = Nokogiri::HTML(open(profile_url))
    profile_page.css("div.social-icon-container").each do |links|
      content[:bio] = profile_page.css("div.description-holder p").text
      content[:profile_quote] = profile_page.css("div.profile-quote").text

      links.css("a").each do |link|
        if link.attributes["href"].value.include?("twitter")
          content[:twitter] = link.attributes["href"].value
        elsif link.attributes["href"].value.include?("linkedin")
          content[:linkedin] = link.attributes["href"].value
        elsif link.attributes["href"].value.include?("github")
          content[:github] = link.attributes["href"].value
        elsif link.attributes["href"].value.include?("http")
          content[:blog] = link.attributes["href"].value
        end
      end
    end
    content
  end


end
