require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))

    students = page.css("div.student-card").map.with_index do |student, i|
      name = page.css("div.student-card div.card-text-container h4.student-name")[i].text
      location = page.css("div.student-card div.card-text-container p.student-location")[i].text
      url = index_url + page.css("div.student-card a")[i]["href"]

      {name: name, location: location, profile_url: url}
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    
    profile_attributes = {}
    social_links = page.css("div.social-icon-container a")

    social_links.each do |link|
      if link["href"].end_with?(".com/")
        profile_attributes[:blog] = link["href"] 
      elsif link["href"].match(/https:\/\/twitter.com/)
        profile_attributes[:twitter] = link["href"]
      elsif link["href"].match(/https:\/\/.+in/)
        profile_attributes[:linkedin] = link["href"]
      elsif link["href"].match(/https:\/\/github.com/)
        profile_attributes[:github] = link["href"]
      end
    end

    profile_attributes[:profile_quote] = page.css("div.profile-quote").text
    profile_attributes[:bio] = page.css("div.bio-content div.description-holder p").text

    profile_attributes 
  end

end

