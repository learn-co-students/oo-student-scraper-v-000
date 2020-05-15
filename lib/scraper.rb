require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    site = Nokogiri::HTML(open(index_url))
    student_list = []
        site.css("div.student-card").collect do |student|
      student_info = {
            name: student.css(".student-name").text,
            location: student.css(".student-location").text,
            profile_url: student.css("a").attribute("href").value
      }
            student_list << student_info
        end
    student_list
end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    student_list = {}
    profile.css("div.social-icon-container a").each do |student|
      if student.attribute("href").value.include?("twitter")
        student_list[:twitter] = student.attribute("href").value
      elsif student.attribute("href").value.include?("linkedin")
        student_list[:linkedin] = student.attribute("href").value
      elsif student.attribute("href").value.include?("github")
        student_list[:github] = student.attribute("href").value
      else student_list[:blog] = student.attribute("href").value
      end
    end
    student_list[:profile_quote] = profile.css("div.profile-quote").text
    student_list[:bio] = profile.css("div.description-holder p").text
    student_list
  end
end