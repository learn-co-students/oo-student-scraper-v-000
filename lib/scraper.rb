require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    return_array = []

    doc = Nokogiri::HTML(open(index_url))	

    names = doc.css("div.student-card h4.student-name")
    locations = doc.css("div.student-card p.student-location")
    profile_urls = doc.css("div.student-card a")

    loops = names.size

    loops.times do |i|
      hash = {name: names[i].text, 
              location: locations[i].text,
              profile_url: profile_urls[i].attribute('href').value}
      return_array << hash 
    end

    return_array
  end

  def self.scrape_profile_page(profile_url)
    return_hash = {}

    doc = Nokogiri::HTML(open(profile_url))

    social_elements = doc.css("div.social-icon-container a")
    
    social_elements.each do |element|
      link = element.attribute('href').value
      if link.include?("twitter")
        return_hash[:twitter] = link
      elsif link.include?("linkedin")
        return_hash[:linkedin] = link
      elsif link.include?("github")
        return_hash[:github] = link
      else
        return_hash[:blog] = link
      end
    end

    return_hash[:profile_quote] = doc.css("div.profile-quote").text

    return_hash[:bio] = doc.css("div.bio-content p").text

    return_hash
  end
end

d = Scraper.scrape_profile_page("./fixtures/student-site/students/joe-burgess.html")