require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    students = []
    page.css(".student-card").each do |student|
      student_name = student.css("h4.student-name").text
      student_location = student.css("p.student-location").text
      student_profile_url = "./fixtures/student-site/" + student.css("a").attribute("href").value
      students << {name: student_name, location: student_location, profile_url: student_profile_url}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
      student = Nokogiri::HTML(open(profile_url))
      student_profile = {}
      student.css("div.social-icon-container a").each do |social|
        profile_page = social.attribute("href").value
        if profile_page.include?("twitter")
          student_profile[:twitter] = profile_page
        elsif profile_page.include?("linkedin")
          student_profile[:linkedin] = profile_page
        elsif profile_page.include?("github")
          student_profile[:github] = profile_page
        else
          student_profile[:blog] = profile_page
        end
        quote = student.css("div.profile-quote").text
        bio = student.css("div.description-holder p").text

        student_profile[:profile_quote] = quote
        student_profile[:bio] = bio
      end
      student_profile
    end

end
