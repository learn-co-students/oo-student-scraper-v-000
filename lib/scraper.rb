require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  #method takes argument of URL using nokogiri and open-uri, return hash
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []

    #hash to include name, location, and profile_url
      doc.css("div.student-card").each do |student|
      student_cards = {}
        student_cards[:name] = student.css('.student-name').text
        student_cards[:location] = student.css('.student-location').text
        student_cards[:profile_url] = student.css("a").attribute("href").value
        students << student_cards
    end
    students
  end

  #method takes argument of URL using nokogiri and open-uri, return hash
  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_hash = {}
    #hash to include twitter, linkedin, github, blog, profile_quote, and bio
    #include defaults just in case profile doesn't contain one
    doc.css("div.social-icon-container a").each do |profiles|
      if profiles.attr('href').include?("twitter")
        student_hash[:twitter] = profiles.attr('href')
      elsif profiles.attr('href').include?("linkedin")
        student_hash[:linkedin] = profiles.attr('href')
      elsif profiles.attr('href').include?("github")
        student_hash[:github] = profiles.attr('href')
      elsif profiles.attr('href').include?(".com")
        student_hash[:blog] = profiles.attr('href')
      end
    student_hash[:profile_quote] = doc.css(".profile-quote").text
    student_hash[:bio] = doc.css(".description-holder p").text
  end
  student_hash
end
  #binding.pry
end
