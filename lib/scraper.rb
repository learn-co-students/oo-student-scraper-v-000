require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_index = Nokogiri::HTML(open(index_url))
    students = []
    student_body = student_index.css("h4").size

    i = 0
    while i < student_body do
      student_name = student_index.css("h4")[i].text
      student_location = student_index.css("p")[i].text
      student_link = student_index.css("div .student-card a")[i].attr("href")
      students << {name: student_name, location: student_location, profile_url: student_link}
    i+=1
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student_info = Nokogiri::HTML(open(profile_url))
    links = {}

    student_info.css("div .social-icon-container a").map do |social|
      media = social.attr("href")
      if media.include?("twitter")
        links[:twitter] = media
      elsif media.include?("linkedin")
        links[:linkedin] = media
      elsif media.include?("github")
        links[:github] = media
      else
        links[:blog] = media
      end
    end

    links[:profile_quote] = student_info.css("div .profile-quote").text if student_info.css("div .profile-quote").text
    links[:bio] = student_info.css("div .description-holder p").text if student_info.css("div .description-holder p").text

    links
  end
end
