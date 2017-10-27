require 'open-uri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    index_hash = doc.css("div.student-card").map do |student|
      student_hash = {}
      student_hash[:name] = student.css(".student-name").text
      student_hash[:location] = student.css(".student-location").text
      student_hash[:profile_url] = student.css("a").attribute("href").value
      student_hash
    end
    index_hash
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile_hash = doc.css("div.social-icon-container").map do |profile|
      #:twitter, :linkedin, :github, :blog, :profile_quote, :bio,
      profile.each {|attribute, value| self.send( ("#{attribute}="), value)}
    end
    profile_hash
  end

end
