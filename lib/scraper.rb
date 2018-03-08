require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    doc = Nokogiri::HTML(html)

    students_array = []

    doc.css("div.student-card").each do |student|
      student_info = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
      students_array << student_info
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    doc = Nokogiri::HTML(html)

    attributes = {}

      links = doc.css(".social-icon-container a").map { |link| link.attribute('href').value }

      links.each do |link|
        if link.include? "twitter"
          attributes[:twitter] = link
        elsif link.include? "linkedin"
          attributes[:linkedin] = link
        elsif link.include? "github"
          attributes[:github] = link
        else
          attributes[:blog] = link
        end
        attributes[:profile_quote] = doc.css(".profile-quote").text
        attributes[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text if doc.css("div.bio-content.content-holder div.description-holder p")
      end
    attributes
  end
end
