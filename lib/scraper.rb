require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    #responsible for scraping the index page that lists all of the students
    students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css("div.student-card").collect do |info|
        name = info.css("h4.student-name").text
        location = info.css("p.student-location").text
        profile_url = index_url + info.css("a").attribute("href").value
        students << {name: name, location: location, profile_url: profile_url}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    #responsible for scraping an individual student's profile page to get further information about that student
    doc = Nokogiri::HTML(open(profile_url))
    profile_quote = doc.css("div.profile-quote").text
    bio = doc.css("div.description-holder p").text
    profile = {profile_quote: profile_quote, bio: bio}

    doc.css("div.social-icon-container a").each do |links|
      url = links.attribute("href").value
      if url.include?("twitter")
        profile[:twitter] = url
      elsif url.include?("linkedin")
        profile[:linkedin] = url
      elsif url.include?("github")
        profile[:github] = url
      else
        profile[:blog] = url
      end
    end
    profile
  end

end
