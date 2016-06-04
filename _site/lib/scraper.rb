require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    student_array = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card a").each do |student|
      student_hash = {}
      student_hash[:name] = student.css("div.card-text-container .student-name").text
      student_hash[:location] = student.css("div.card-text-container .student-location").text
      student_hash[:profile_url] = "http://127.0.0.1:4000/#{student["href"]}"
      student_array << student_hash
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    student_hash = {}
    doc = Nokogiri::HTML(open(profile_url))
    social = doc.css("div.social-icon-container")
    name_elements = doc.css(".profile-name").text.downcase.split
    social.css("a").each do |child|
      if child['href'].include?('twitter')
        student_hash[:twitter] = child['href']
      elsif child['href'].include?('linkedin')
        student_hash[:linkedin] = child['href']
      elsif child['href'].include?('github')
        student_hash[:github] = child['href']
      elsif child['href'].include?('youtube')
        student_hash[:youtube] = child['href']
      else
        student_hash[:blog] = child['href']
      end
    end
    student_hash[:profile_quote] = doc.css(".profile-quote").text
    student_hash[:bio] = doc.css("div.description-holder p").text
    student_hash
  end

end

