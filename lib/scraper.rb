require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css(".roster-cards-container .student-card").each do |student|
      student = {
        :name => student.css(".card-text-container").first.css("h4").text,
        :location => student.css(".card-text-container").first.css("p").text,
        :profile_url => student.css("a").attribute("href").text
      }
      students << student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    hash = {}
    hash[:profile_quote] = doc.css(".profile-quote").text
    hash[:bio] = doc.css(".description-holder p").text
    links = doc.css(".social-icon-container a").each do |link|
      if link.attribute("href").text.include?("twitter")
        hash[:twitter] = link.attribute("href").text
      elsif link.attribute("href").text.include?("linkedin")
        hash[:linkedin] = link.attribute("href").text
      elsif link.attribute("href").text.include?("github")
        hash[:github] = link.attribute("href").text
      else
        hash[:blog] = link.attribute("href").text
      end
    end
    hash
  end

end
