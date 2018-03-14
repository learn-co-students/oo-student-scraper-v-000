require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    indexed_students = []
    index_page.css(".student-card").each do |student|
      url = student.css("a").attribute("href").value
      name = student.css("h4").text
      location = student.css("p.student-location").text
      indexed_students << {name: name, location: location, profile_url: url}
    end
    indexed_students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student = {}
    social_links = []
    profile_page.css(".social-icon-container a").each {|social| social_links << social.attribute("href").value}
    student[:bio] = profile_page.css(".description-holder p").text
    student[:profile_quote] = profile_page.css(".profile-quote").text
    if social_links.any? {|i| i.include?("twitter.com")}
      twitter = social_links.detect {|i| i.include?("twitter.com")}
      social_links.delete(twitter)
      student[:twitter] = twitter
    end
    if social_links.any? {|i| i.include?("github.com")}
      github = social_links.detect {|i| i.include?("github.com")}
      social_links.delete(github)
      student[:github] = github
    end
    if social_links.any? {|i| i.include?("linkedin.com")}
      linkedin = social_links.detect {|i| i.include?("linkedin.com")}
      social_links.delete(linkedin)
      student[:linkedin] = linkedin
    end
    student[:blog] = social_links[0] if social_links.size > 0
    student
  end
  
end
