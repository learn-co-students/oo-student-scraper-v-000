require 'open-uri'
require 'pry'

require_relative '../config.rb'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    students = []
    
    doc.css(".student-card").each do |student|
    students << {
      :name => student.css("h4.student-name").text,
      :location => student.css("p.student-location").text,
      :profile_url => "http://127.0.0.1:4000/"+student.css("a").attribute("href")
    }
  end
  return students 
  end


  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    students = {}
    doc.css(".social-icon-container a").each do |x|
      profile = x.attribute("href").value
      students[:twitter] = profile if profile.include?("twitter")
      students[:linkedin] = profile if profile.include?("linkedin")
      students[:github] = profile if profile.include?("github")
      students[:blog] = profile if x.css("img").attribute("src").text.include?("rss")
      students[:profile_quote] = doc.css(".profile-quote").text
      students[:bio] = doc.css(".description-holder p").text
  end
  students  
  end

end



