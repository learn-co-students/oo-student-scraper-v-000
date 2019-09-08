require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card").each do |student|
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        student_profile = student.css("a")[0]["href"]

        students << {name: student_name, location: student_location, profile_url: student_profile}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student = {}

    profile_page.css(".social-icon-container a").each do |link|
      href = link.attribute("href").value
      if href.include?("twitter")
        student[:twitter] = href
      elsif href.include?("linkedin")
        student[:linkedin] = href
      elsif href.include?("github")
        student[:github] = href
      else
        student[:blog] = href
      end
    end

    student[:profile_quote] = profile_page.css(".profile-quote").text
    student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text

    student
  end

end
