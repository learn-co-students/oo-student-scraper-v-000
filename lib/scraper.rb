require 'open-uri'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    students_list = []
    page.css(".student-card").each do |student|
      students_list << {
        name: student.css(".student-name").text,
        location: student.css(".student-location").text,
        profile_url: "http://127.0.0.1:4000/" + student.css("a").attribute("href").value 
      }
    end
    students_list 
  end

  def self.scrape_profile_page(profile_url)
    page=Nokogiri::HTML(open(profile_url))
    student_profile ={}
    page.css(".social-icon-container a").each do |student|
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
    student_profile[:profile_quote]=page.css(".profile-quote").text
    student_profile[:bio]=page.css(".bio-block").css("p").text
    student_profile
  end

end