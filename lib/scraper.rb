require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    students_info = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    doc.css(".student-card").each do |stud|
        stud_name = stud.css(".student-name").text
        stud_location = stud.css(".student-location").text
        stud_profile_url = stud.css("a").first.attr("href")
        students_info << {name: stud_name, location: stud_location, profile_url: stud_profile_url}
    end
    students_info
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    collection = {}
    doc.css(".social-icon-container").children.css("a").each do |a|
      if a.attribute("href").value.include?("twitter")
        collection[:twitter] = a.attribute("href").value
      elsif a.attribute("href").value.include?("linkedin")
        collection[:linkedin] = a.attribute("href").value
      elsif a.attribute("href").value.include?("github")
        collection[:github] = a.attribute("href").value
      else collection[:blog] = a.attribute("href").value
      end
    end
    if doc.css(".profile-quote")
      collection[:profile_quote] = doc.css(".profile-quote").text
    end
    if doc.css(".description-holder p")
      collection[:bio] = doc.css(".description-holder p").text
    end
    collection
  end
end
