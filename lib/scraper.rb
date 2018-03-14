require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_info = doc.css(".student-card")

    student_array = []

    student_info.each do |student|
      student_hash = {}
      student_hash[:name] = student.css("h4").text
      student_hash[:location] = student.css("p").text
      student_hash[:profile_url] = student.css("a")[0]["href"]
      student_array << student_hash
    end

    student_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    social_info = doc.css(".social-icon-container a")
    #profile_info = doc.css(".main-wrapper profile")

    profile_hash = {}

    social_info.each do |info|
      if info["href"].include?("twitter")
          profile_hash[:twitter] = info["href"]
      elsif info["href"].include?("linkedin")
        profile_hash[:linkedin] = info["href"]
      elsif info["href"].include?("github")
        profile_hash[:github] = info["href"]
      else
        profile_hash[:blog] = info["href"]
      end
    end

    profile_hash[:profile_quote] = doc.css(".profile-quote").text
    profile_hash[:bio] = doc.css(".description-holder p").text

    profile_hash
  end

end #Scraper Class end

=begin
profile_hash[:twitter] = social_info[0]["href"] if social_info[0]["href"] == true
profile_hash[:linkedin] = social_info[1]["href"] if social_info[1] == true
profile_hash[:github] = social_info[2]["href"] if social_info[2]["href"] == true
profile_hash[:blog] = social_info[3]["href"] if social_info[3]["href"] == true
=end
