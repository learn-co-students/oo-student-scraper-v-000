require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    profiles = []
    
    ind = Nokogiri::HTML(open(index_url))
    students = ind.css(".student-card")

    students.each do |profile|
      name = profile.css(".student-name").text
      location = profile.css(".student-location").text
      profile_url = "http://127.0.0.1:4000/#{profile.css("a")[0]["href"]}"
      profiles << {name: name, location: location, profile_url: profile_url}
    end
    profiles
  end

  def self.scrape_profile_page(profile_url)
    info = {}
    
    prof = Nokogiri::HTML(open(profile_url))
    
    info[:profile_quote] = prof.css(".profile-quote").text
    info[:bio] = prof.css(".description-holder p").text
    
    prof.css(".social-icon-container a").each do |student|
      student_info = student.attribute("href").text
      info[:twitter] = student_info if student_info.include?("twitter")
      info[:linkedin] = student_info if student_info.include?("linkedin")
      info[:github] = student_info if student_info.include?("github")
      info[:blog] = student_info if student.css("img").attribute("src").text.include?("rss")
    end
    info
  end

end

