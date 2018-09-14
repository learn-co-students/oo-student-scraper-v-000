require 'nokogiri'
require 'open-uri'
require 'pry'

# students: student_index.css("div.student-card")
# name: student.css("h4.student-name").text
# location: student.css("p.student-location").text


class Scraper

  def self.scrape_index_page(index_url)
    # Opens a file and reads it into a variable
    html = File.read('fixtures/student-site/index.html')
    student_index = Nokogiri::HTML(html)

    students = []

    # Iterate through the students
    student_index.css("div.student-card").each do |student|
      students << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end

    students

  end

# twitter url
# linkedin url, github url
# blog url, profile quote, and bio.

  def self.scrape_profile_page(profile_url)
    student_profile = Nokogiri::HTML(File.read(profile_url))
    student_hash = {}
    student_profile.css("div.social-icon-container a").each do |social_att|
      if social_att.attribute("href").value.include?("twitter")
        student_hash[:twitter] = social_att.attribute("href").value
      elsif social_att.attribute("href").value.include?("linkedin")
        student_hash[:linkedin] = social_att.attribute("href").value
      elsif social_att.attribute("href").value.include?("github")
        student_hash[:github] = social_att.attribute("href").value
      else
        student_hash[:blog] = social_att.attribute("href").value

      end

    student_hash[:profile_quote] = student_profile.css("div.profile-quote").text.strip
    student_hash[:bio] = student_profile.css("div.bio-content.content-holder div.description-holder p").text

    end
    student_hash
  end
end
