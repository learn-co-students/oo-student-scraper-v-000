require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    # name, location, profile url
    page = Nokogiri::HTML(open(index_url))
    page.css(".student-card").each do |selector|
      h = {}
      h[:name] = selector.css(".student-name").text
      h[:location] = selector.css(".student-location").text
      h[:profile_url] = "./fixtures/student-site/" + selector.css("a")[0]["href"]
      students << h
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    # :twitter, linkedin, github, blog, profile_qyote, bio
    page = Nokogiri::HTML(open(profile_url))
    s = {}
    social_links = page.css(".social-icon-container a").collect {|link| link['href']}
    social_links.each do |link|
      if link.include?("twitter")
        s[:twitter] = link
      elsif link.include?("linkedin")
        s[:linkedin] = link
      elsif link.include?("github")
        s[:github] = link
      else
        s[:blog] = link
      end    
    end
    s[:profile_quote] = page.css('.profile-quote').text
    s[:bio] = page.css('.description-holder p').text
    s
  end

end