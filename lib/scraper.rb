require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".student-card")
    scraped_students = []
    students.each do |student|
      hash = Hash.new
      hash[:name] = student.css(".student-name").text
      hash[:location] = student.css(".student-location").text
      hash[:profile_url] = student.css("a").attribute("href").value
      scraped_students << hash
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    profile_data = doc.css(".main_wrapper profile")
    scraped_student = {}
    profile_data.each do |profile|
      hash = Hash.new
      hash[:twitter] = ""
      hash[:linkedin] = ""
      hash[:profile_quote] = ""
      hash[:github] = ""
      hash[:blog] = ""
      hash[:bio] = ""
      scraped_student << hash
    end
    scraped_student
  end

end
