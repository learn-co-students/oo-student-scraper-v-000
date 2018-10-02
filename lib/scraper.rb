require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
     students_index = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
    students = []
    students_index.css(".student-card").each do |student|
      student_name = student.css("h4.student-name").text
      student_location = student.css("p.student-location").text
      profile_url = student.css("a").attribute("href").value
      student_attributes = {:name => student_name, :location => student_location, :profile_url => profile_url}
      students << student_attributes
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student_profile = Nokogiri::HTML(open(profile_url))
    scraped_student = {}
    social_links = student_profile.css(".social-icon-container").children.css("a").collect { |i| i.attribute('href').value }
    social_links.each do |social_link|
      if social_link.include?("twitter")
        scraped_student[:twitter] = social_link
      elsif social_link.include?("linkedin")
        scraped_student[:linkedin] = social_link
      elsif social_link.include?("github")
        scraped_student[:github] = social_link
      else
        scraped_student[:blog] = social_link
      end
    end
    scraped_student[:profile_quote] = student_profile.css(".profile-quote").text
    scraped_student[:bio] = student_profile.css(".description-holder p").text
    scraped_student
  end
end 

