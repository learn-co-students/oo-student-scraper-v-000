require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []

    doc.css(".student-card").each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile_url = student.css("a").attribute("href").value
      students << {name: name, location: location, profile_url: profile_url}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_profile_hash = {}

    doc.css(".social-icon-container a").each do |a|
      link = a.attribute("href").value
      if !link.match(/[^\/]\/[a-z]+/)
        symbol = :blog
      else
        symbol = link.match(/[a-z0-9]+\.[a-z]{2,5}\b/)[0].gsub(".com", "").to_sym
      end
      student_profile_hash[symbol] = link
    end

    student_profile_hash[:profile_quote] = doc.css(".profile-quote").text
    student_profile_hash[:bio] = doc.css(".description-holder p").text
    student_profile_hash
  end

end

