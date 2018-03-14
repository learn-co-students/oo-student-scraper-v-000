require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = []
    doc.css("div.student-card").each { |student|
      new_hash = {
        :name=>student.css(".student-name").text,
        :location=>student.css(".student-location").text,
        :profile_url=>student.css("a").map { |link| link['href'] }[0]
      }
      students << new_hash
    }
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    attr_hash = {}
    attr_hash[:bio] = doc.css(".description-holder").css("p").text
    attr_hash[:profile_quote] = doc.css(".profile-quote").text
    attr_hash
    links = doc.css(".social-icon-container").css("a").collect{ |a| a.attribute("href").value}
    links.each {|link|
      if link.include?("twitter")
        attr_hash[:twitter] = link
      elsif link.include?("linkedin")
        attr_hash[:linkedin] = link
      elsif link.include?("github")
        attr_hash[:github] = link
      else
        attr_hash[:blog] = link
      end
    }
    attr_hash
  end

end
