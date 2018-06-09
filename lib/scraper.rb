require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.roster-cards-container").each {|card|
      card.css(".student-card").each { |student|
        name = student.css(".student-name").text
        location = student.css(".student-location").text
        profile_url = student.css("a").attr("href").text
        students << {:name => name, :location => location, :profile_url => profile_url}
      }
    }
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_info = {}
    student_info[:profile_quote] = doc.css(".profile-quote").text
    student_info[:bio] = doc.css(".bio-content p").text
    doc.css(".social-icon-container a").each { |icon|
      link = "#{icon.attr("href")}"
      if link.include?("twitter")
        student_info[:twitter] = link
      elsif link.include?("linkedin")
        student_info[:linkedin] = link
      elsif link.include?("github")
        student_info[:github] = link
      else
        student_info[:blog] = link
      end
    }
    student_info
  end

end
