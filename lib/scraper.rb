require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css(".student-card a").each do |studentCard|
      student_link = "#{studentCard.attr('href')}"
      student_name = studentCard.css(".student-name").text
      student_location = studentCard.css(".student-location").text
      students << {name: student_name, location: student_location, profile_url: student_link}
    end

    students

  end

  def self.scrape_profile_page(profile_url)
    student = {}
    doc = Nokogiri::HTML(open(profile_url))

    links = doc.css(".social-icon-container").children.css("a").map { |alink|
      alink.attribute('href').value
    }

    links.each do |link|
      link.include?("linkedin") ?  student[:linkedin] = link : ""
      link.include?("github") ?  student[:github] = link : ""
      link.include?("twitter") ?  student[:twitter] = link : ""
      !link.include?("linkedin") && !link.include?("twitter") && !link.include?("github") ? student[:blog] = link : ""
    end

    doc.css(".profile-quote") ? student[:profile_quote] = doc.css(".profile-quote").text : ""
    doc.css(".description-holder p") ? student[:bio] = doc.css(".description-holder p").text : ""

    student

  end

end
