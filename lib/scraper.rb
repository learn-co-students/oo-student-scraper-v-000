require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.student-card").each do |attribute|
      student_name = attribute.css("h4.student-name").text
      student_location = attribute.css("p.student-location").text
      student_link = attribute.children[1].attributes["href"].value

      students << {name: student_name, location: student_location, profile_url: student_link }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    links = doc.css("div.social-icon-container a").collect {|e| e.attribute("href").value}
    links.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      else
        student[:blog] = link
      end
    end
    student[:profile_quote] = doc.css("div.profile-quote").text unless !doc.css("div.profile-quote")
    student[:bio] = doc.css("div.description-holder p").text unless !doc.css("div.description-holder p")

    student
  end

end
