require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css(".student-card").each do |student|
        student_location = student.css("p.student-location").text
        student_name = student.css("div.card-text-container h4.student-name").text
        student_profile_url = student.css("a").attribute("href").value
        students << {:name => student_name, :location => student_location, :profile_url => student_profile_url}
      end
    students
  end

  def self.scrape_profile_page(profile_url)
    student_profile = {}
    student_page = Nokogiri::HTML(open(profile_url))
    links = student_page.css(".social-icon-container a").map{|icon| icon.attribute('href').value}
    links.each do |link|
      if link.include?("twitter")
        student_profile[:twitter] = link
      elsif link.include?("linkedin")
        student_profile[:linkedin] = link
      elsif link.include?("github")
        student_profile[:github] = link
      else
        student_profile[:blog] = link
      end
    end
    student_profile[:profile_quote] = student_page.css(".vitals-text-container .profile-quote").text
    student_profile[:bio] = student_page.css(".details-container .description-holder p").text
    student_profile
  end
end
