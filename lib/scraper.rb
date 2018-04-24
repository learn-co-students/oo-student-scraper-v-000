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
   #binding.pry
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    document = Nokogiri::HTML(html)
    student_hash = Hash.new
    
    i = 0 
    while i < 6
    if document.css("a")[i]["href"].match(/.*twitter.com.*/) 
        student_hash[:twitter] = url
    end 
  end
    # student_hash[:twitter] =
    # student_hash[:linkedin] = 
    # student_hash[:github] =
    # student_hash[:blog] = 
    # student_hash[:profile_quote] = document.css(".profile-quote").text
    # student_hash[:bio] = document.css("p")[0].text
    # student_hash
    binding.pry
  end

end

