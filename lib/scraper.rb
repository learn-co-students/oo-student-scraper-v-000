require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []

    doc.css(".student-card").each do |student|
      students << {
        name: student.css(".student-name").text,
        location: student.css(".student-location").text,
        profile_url: student.css("a")[0]["href"]
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    student_profile = {}

      doc.css(".social-icon-container a").each do |icon|
        if icon[:href].include?("twitter")
          student_profile[:twitter] = icon["href"]
        elsif icon[:href].include?("linkedin")
          student_profile[:linkedin] = icon["href"]
        elsif icon[:href].include?("github")
          student_profile[:github] = icon["href"]
        else
          student_profile[:blog] = icon["href"]
        end
      end

    student_profile[:profile_quote] = doc.css(".profile-quote").text
    student_profile[:bio] = doc.css(".bio-content p").text

    student_profile
  end
end
