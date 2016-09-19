require_relative "../lib/command_line_interface.rb"
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    students = Nokogiri::HTML(html).css(".student-card")
    students_array = []
    students.each do |student|
      students_array << {
        :name => student.css(".card-text-container .student-name").text,
        :location => student.css(".card-text-container .student-location").text,
        :profile_url => CommandLineInteface::BASE_PATH+student.css("a").first.attributes["href"].value
      }
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student = {}
    social = doc.css(".social-icon-container a")
    social.each do |s|
      if s.attributes["href"].value.include? "twitter"
        student[:twitter] = s.attributes["href"].value
      elsif s.attributes["href"].value.include? "linkedin"
        student[:linkedin] = s.attributes["href"].value
      elsif s.attributes["href"].value.include? "github"
        student[:github] = s.attributes["href"].value
      elsif s.attributes["href"].value.include? "facebook"
        student[:facebook] = s.attributes["href"].value
      else
        student[:blog] = s.attributes["href"].value
      end
    end

    student[:profile_quote] = doc.css(".profile-quote").text
    student[:bio] = doc.css(".bio-content .description-holder").text.strip
    student
  end

end
