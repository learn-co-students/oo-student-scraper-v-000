require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    array = []
    
    Nokogiri::HTML(open(index_url)).css(".student-card").each do |student|
      complete_student = {}
      student_name = student.css(".student-name").text
      student_location = student.css(".student-location").text
      student_url = student.css("a").attribute("href").value
      complete_student[:name] = student_name
      complete_student[:location] = student_location
      complete_student[:profile_url] = student_url
      array << complete_student
    end
    
    array
  end

  def self.scrape_profile_page(profile_url)
    hash = {}
    Nokogiri::HTML(open(profile_url)).css(".social-icon-container").css("a").each do |student|
      url = student.attribute("href").value
      if url.include? "twitter.com"
        hash[:twitter] = url
      elsif url.include? "linkedin.com"
        hash[:linkedin] = url
      elsif url.include? "github.com"
        hash[:github] = url 
      else
        hash[:blog] = url
      end
    end
    
    hash[:profile_quote] = Nokogiri::HTML(open(profile_url)).css(".profile-quote").text if Nokogiri::HTML(open(profile_url)).css(".profile-quote")
    
    hash[:bio] = Nokogiri::HTML(open(profile_url)).css("div.bio-content.content-holder div.description-holder p").text if Nokogiri::HTML(open(profile_url)).css("div.bio-content.content-holder div.description-holder p")
    
    hash
  end

end

