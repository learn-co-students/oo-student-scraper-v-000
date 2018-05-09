require 'nokogiri'
require 'open-uri'
require 'pry'


class Scraper
  
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
    list = doc.css("div.student-card")

    students = []

    list.each do |student|
      name = student.css("h4.student-name").text
      location = student.css("p.student-location").text
      profile_url = student.css("a").attribute("href").value
      students << {name: name, location: location, profile_url: profile_url}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
   
    profiles = {}
   
    profiles[:profile_quote] = doc.css(".profile-quote").text if doc.css(".profile-quote")
    profiles[:bio] = doc.css(".description-holder p").text if doc.css(".description-holder p")
    
    page = doc.css(".social-icon-container").children.css("a").map {|link| link.attribute("href").value}
    
    page.each do |site|
      if site.include?("twitter")
        profiles[:twitter] = site
      elsif site.include?("linkedin")
        profiles[:linkedin] = site
      elsif site.include?("github")
        profiles[:github] = site
      else
        profiles[:blog] =site
      end
    end 
    
    profiles
  end

end
