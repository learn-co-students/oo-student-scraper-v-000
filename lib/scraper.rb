require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_array = []
    #student_name = doc.css(".student-card").first.css("h4").text
    #student_location = doc.css(".student-card").first.css(".student-location").text
    #profile_url = doc.css(".student-card a").first["href"]
    doc.css(".student-card").each_with_index do |student, index|
      student_info_hash = {}
      student_info_hash[:name] = doc.css(".student-card")[index].css("h4").text
      student_info_hash[:location] = doc.css(".student-card")[index].css(".student-location").text
      student_info_hash[:profile_url] = "./fixtures/student-site/#{doc.css(".student-card a")[index]["href"]}"
      student_array << student_info_hash
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    scraped_student = {}
    social_media = doc.css(".social-icon-container a")
    social_urls = []
    social_media.each_with_index do |profile, index|
      social_urls << doc.css(".social-icon-container a")[index]["href"]
    end
    #social_urls
    scraped_student[:profile_quote] = doc.css(".vitals-text-container div.profile-quote").text
    scraped_student[:bio] = doc.css(".description-holder p").text    
    scraped_student[:twitter] = social_urls.find {|url| url.include?("twitter")}   if social_urls.find {|url| url.include?("twitter")}  
    scraped_student[:linkedin] = social_urls.find {|url| url.include?("linkedin")} if social_urls.find {|url| url.include?("linkedin")}
    scraped_student[:github] = social_urls.find {|url| url.include?("github")} if social_urls.find {|url| url.include?("github")}
    scraped_student[:blog] = social_urls.find {|url| url.end_with?(".com/")} if social_urls.find {|url| url.end_with?(".com/")}
    scraped_student
  end

end

