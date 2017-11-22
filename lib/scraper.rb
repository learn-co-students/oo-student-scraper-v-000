require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []

    doc.css(".student-card").each {|person|
      students << {
        :name => person.css(".student-name").text,
        :location => person.css(".student-location").text,
        :profile_url => person.css("a").attribute("href").value
      }
    }
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    attributes = {}

    social = doc.css(".social-icon-container a")
    social.each {|link|
      link_value = link.attribute("href").value
      if link_value.include?("twitter")
        attributes[:twitter] = link_value
      elsif link_value.include?("linkedin")
        attributes[:linkedin] = link_value
      elsif link_value.include?("github")
        attributes[:github] = link_value
      else
        attributes[:blog] = link_value
      end
    }
    attributes[:profile_quote] = doc.css(".profile-quote").text
    attributes[:bio] = doc.css(".bio-content p").text

    attributes
  end

end
