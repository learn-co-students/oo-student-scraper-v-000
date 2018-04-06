require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card")
    students_array = []

    students.each do |student|
      student_hash = {}
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      links = student.css("a")
      profile_url = nil
      links.each do |link|
        profile_url = link["href"]
      end

      student_hash[:name] = name
      student_hash[:location] = location
      student_hash[:profile_url] = profile_url
      students_array << student_hash
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)
    student_data = Nokogiri::HTML(open(profile_url))
    attributes_hash = {}
    links = student_data.css(".social-icon-container").children.css("a").map do |e|
      e.attribute("href").value
    end
    links.each do |link|
      attributes_hash[:twitter] = link if link.include?("twitter")
      attributes_hash[:linkedin] = link if link.include?("linkedin")
      attributes_hash[:github] = link if link.include?("github")
      attributes_hash[:blog] = link if link.include?("blog")
    end
    if student_data.css("div.vitals-text-container div.profile-quote")
      attributes_hash[:profile_quote] = student_data.css("div.vitals-text-container div.profile-quote").text
    end
    if student_data.css("div.bio-content.content-holder div.description-holder p")
      attributes_hash[:bio] = student_data.css("div.bio-content.content-holder div.description-holder p").text
    end
    attributes_hash
  end

end
