require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css("div.student-card a").each do |element|
      name = element.css("div.card-text-container h4").text
      location = element.css("div.card-text-container p").text
      link = element.attribute("href").value
      students << {name: name, location: location, profile_url: link}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    attributes = {}
    links = []
    doc = Nokogiri::HTML(open(profile_url))
    doc.css("div.social-icon-container a").each do |element|
      links << element.attribute("href").value
    end
    links.each do |link|
      if link.include?('twitter')
        attributes[:twitter] = link
      elsif link.include?('linkedin')
        attributes[:linkedin] = link
      elsif link.include?('github')
        attributes[:github] = link
      else
        attributes[:blog] = link
      end
    end
    attributes[:profile_quote] = doc.css("div.profile-quote").text
    attributes[:bio] = doc.css("div.bio-content div.description-holder p").text
    attributes
  end

end
