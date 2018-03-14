require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students_array = []
    students = doc.css(".student-card")
    students.each do |student|
      name = student.css(".card-text-container .student-name").text
      location = student.css(".student-location").text
      profile_url = student.css("a")[0]["href"]
      student_hash = {name: name, location: location, profile_url: profile_url}
      students_array << student_hash
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)
    student_hash = {}
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    links = doc.css(".social-icon-container a").map{|x| x.attribute('href').value}
    links.each do |link|
      if link.include?("twitter")
        student_hash[:twitter] = link
      elsif link.include?("linkedin")
        student_hash[:linkedin] = link
      elsif link.include?("github")
        student_hash[:github] = link
      else
        student_hash[:blog] = link
      end
    end
    student_hash[:profile_quote] = doc.css(".vitals-text-container .profile-quote").text
    student_hash[:bio] = doc.css(".details-container .description-holder p").text

    student_hash
  end

end
