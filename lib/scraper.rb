require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
   document = Nokogiri::HTML(html)
   student_hashes = []

   document.css(".student-card").each do |student|
     temp_hash = Hash.new
     temp_hash[:name] = student.css(".student-name").text
     temp_hash[:location] = student.css(".student-location").text
     temp_hash[:profile_url] = student.css("a")[0]["href"]
     student_hashes << temp_hash
      end 
   student_hashes
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    document = Nokogiri::HTML(html)
    student_hash = Hash.new
 
    i = 1
    while i <= 8
    if document.css("a")[i] != nil
    current_link = document.css("a")[i]["href"]
      if current_link.match(/.*twitter.com.*/) 
        student_hash[:twitter] = current_link
      elsif current_link.match(/.*linkedin.com.*/) 
        student_hash[:linkedin] = current_link
      elsif current_link.match(/.*github.com.*/) 
        student_hash[:github] = current_link
      else 
        student_hash[:blog] = document.css("a")[i]["href"]
      end 
    end 
      i += 1
  end 
    student_hash[:profile_quote] = document.css(".profile-quote").text
    student_hash[:bio] = document.css("p")[0].text
    student_hash
  end


end


