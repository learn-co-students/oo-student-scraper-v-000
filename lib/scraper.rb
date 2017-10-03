require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    students = []

    doc.css(".student-card").each do |student_card|
    students << {
        name: student_card.css(".student-name").text,
        location: student_card.css(".student-location").text,
        profile_url: student_card.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    student = {}

    links = doc.css(".social-icon-container").children.css("a").map { |elem| elem.attribute('href').value}
    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link
      end
    end

    student[:profile_quote] = doc.css(".vitals-text-container .profile-quote").text
    student[:bio] = doc.css(".description-holder p").text

    student
  end

end
