require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("#{index_url}"))
    student_info = []
    students = doc.css(".student-card a")
    students.each do |student|
    student_name = student.css("h4.student-name").text
    student_location = student.css("p.student-location").text
    student_URL = student.attr("href")
    student_info << {name: student_name, location: student_location, profile_url: student_URL}
    end
  student_info
end

  def self.scrape_profile_page(profile_url)
    profile_page = {}
    student_page = Nokogiri::HTML(open("#{profile_url}"))
    #binding.pry
    links = student_page.css(".social-icon-container a")
    links.each do |link|
      if link.attr("href").include?("twitter")
        profile_page[:twitter] = link.attr("href")
      elsif  link.attr("href").include?("git")
        profile_page[:github] = link.attr("href")
      elsif  link.attr("href").include?("linkedin")
        profile_page[:linkedin] = link.attr("href")
      else
        profile_page[:blog] = link.attr("href")
      end
    end
    quote = student_page.css(".vitals-text-container").css(".profile-quote").text
    profile_page[:profile_quote] = quote
    bio = student_page.css(".description-holder").css("p").text
    profile_page[:bio] = bio
    profile_page
  end

end
