require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
    students = []
    index.css("div.roster-cards-container").each do |card|
      index.css(".student-card a").each do |student|
        name = student.css(".student-name").text
        location = student.css(".student-location").text
        profile_link = "./fixtures/student-site/#{student.attr('href')}"
        students << {name: name, location: location, profile_url: profile_link}
        end
      end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_url = Nokogiri::HTML(open(profile_url))
    profile = {}
    urls = profile_url.css(".social-icon-container").children.css("a").map do |a|
      a.attribute("href").value
      end
    urls.each do |url|
      if url.include?("linkedin")
        profile[:linkedin] = url
      elsif url.include?("github")
        profile[:github] = url
      elsif url.include?("twitter")
        profile[:twitter] = url
      else
        profile[:blog] = url
      end
        profile[:bio] = profile_url.css("div.bio-content.content-holder div.description-holder p").text if profile_url.css("div.bio-content.content-holder div.description-holder p")
        profile[:profile_quote] = profile_url.css(".profile-quote").text if profile_url.css(".profile-quote")
      end
    profile
  end

end
