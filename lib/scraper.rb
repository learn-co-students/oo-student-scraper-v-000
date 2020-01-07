require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url))

    students = []

    doc.css(".student-card").each do |student|
      students << {
        name: student.css(".student-name").text,
        location: student.css(".student-location").text,
        profile_url: "./fixtures/student-site/#{student.css("a").attribute("href").value}"
      }
    end

    students
  end

  def self.scrape_profile_page(profile_url)


    doc = Nokogiri::HTML(open(profile_url))

    students = {}

    links = doc.css(".social-icon-container").children.css("a").collect {|link| link.attribute("href").value}

    links.each do |link|

      if link.include?("twitter")
        students[:twitter] = link
      elsif link.include?("linkedin")
        students[:linkedin] = link
      elsif link.include?("github")
        students[:github] = link
      else link.include?("blog")
        students[:blog] = link
      end
    end

    students[:profile_quote] = doc.css(".profile-quote").text
    students[:bio] = doc.css(".description-holder p").text

    students
  end

end
