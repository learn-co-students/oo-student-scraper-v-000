require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []

    doc.css(".student-card").each {|student|
      info = {
      :name => student.css(".student-name").text,
      :location => student.css(".student-location").text,
      :profile_url => student.css("a").attr("href").value
      }
      students << info
      }
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    attributes = {}

    links = profile_page.css(".social-icon-container a").map {|link| link.attribute('href').value}

    links.each {|link|
      if link.include?("twitter")
        attributes[:twitter] = link
      elsif link.include?("linkedin")
        attributes[:linkedin] = link
      elsif link.include?("github")
        attributes[:github] = link
      else
        attributes[:blog] = link
      end
    }

    attributes[:profile_quote] = profile_page.css(".profile-quote").text
    attributes[:bio] = profile_page.css(".description-holder p").text
    
    attributes

  end

end
