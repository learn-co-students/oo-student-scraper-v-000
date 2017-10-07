require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = Array.new
    doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile_url = "#{student.attr("href")}"
      students << {name: name, location: location, profile_url: profile_url}
      end
    end
  students
end

  def self.scrape_profile_page(profile_url)
    profile_html = open(profile_url)
    profile_doc = Nokogiri::HTML(profile_html)
    attributes = {}
    profile_doc.css("div.social-icon-container a").each do |link_xml|
      case link_xml.attribute("href").value
      when /twitter/
        attributes[:twitter] = link_xml.attribute("href").value
      when /github/
        attributes[:github] = link_xml.attribute("href").value
      when /linkedin/
        attributes[:linkedin] = link_xml.attribute("href").value
      else
        attributes[:blog] = link_xml.attribute("href").value
      end
    end

    attributes[:profile_quote] = profile_doc.css(".profile-quote").text
    attributes[:bio] = profile_doc.css("div.bio-content div.description-holder").text.strip
    attributes
  end
end
