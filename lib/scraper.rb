require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students_list = []
    students = doc.css(".student-card")
    students.each do |student|
    students_list << {
      name: student.css("h4").text,
      location: student.css("p").text,
      profile_url: "http://159.203.91.59:30000/" + student.css("a").attribute("href").value
  }
  end
  students_list
end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student_profile = {}
    profiles = doc.css(".social-icon-container a").each do |student|
      if student.attribute("href").value.include?("twitter")
        student_profile[:twitter]=student.attribute("href").value
      elsif student.attribute("href").value.include?("linkedin")
        student_profile[:linkedin]=student.attribute("href").value
      elsif student.attribute("href").value.include?("github")
        student_profile[:github]=student.attribute("href").value
      else student.attribute("href").value.include?("blog")
        student_profile[:blog]=student.attribute("href").value
      end
    end
       student_profile[:profile_quote]=doc.css("div.profile-quote").text
       student_profile[:bio]=doc.css("div.description-holder p").text
       student_profile
  # binding.pry
end

end
# Scraper.scrape_index_page("fixtures/student-site/index.html")
# Scraper.scrape_profile_page("fixtures/student-site/students/ryan-johnson.html")
