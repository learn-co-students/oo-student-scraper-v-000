require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    array_of_hashes = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".roster-cards-container .student-card")
    students.each do |student|
      student_hash = {}
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      url = student.at_css("a[href]")
      student_hash[:name] = name
      student_hash[:location] = location
      student_hash[:profile_url] = url['href']
      array_of_hashes << student_hash
    end
    array_of_hashes
  end

  def self.scrape_profile_page(profile_url)
    attributes_hash = {}
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    social_links = doc.css(".social-icon-container a[href]")
    social_links.each do |link|
      if link['href'].include?("twitter")
        attributes_hash[:twitter] = link['href']
      elsif link['href'].include?("linkedin")
        attributes_hash[:linkedin] = link['href']
      elsif link['href'].include?("github")
        attributes_hash[:github] = link['href']
      elsif link['href'].include?("facebook")
        attributes_hash[:facebook] = link['href']
      else
        attributes_hash[:blog] = link['href']
      end
    end
    attributes_hash[:profile_quote] = doc.css(".profile-quote").text
    attributes_hash[:bio] = doc.css(".details-container .bio-block .bio-content .description-holder p").text
    return attributes_hash
  end
end
