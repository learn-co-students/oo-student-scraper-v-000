require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css(".roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        student_profile_link = "#{student.attr("href")}"
        students << {name: student_name, location: student_location, profile_url: student_profile_link}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student = {}

    profile_page.css(".social-icon-container a").each do |link|
      social = link["href"]
      if social.include?("twitter")
        student[:twitter] = social
      elsif social.include?("github")
        student[:github] = social
      elsif social.include?("linkedin")
        student[:linkedin] = social
      elsif social.include?("youtube")
        student[:youtube] = social
      else
        student[:blog] = social
      end
    end

    student[:profile_quote] = profile_page.css("div.profile-quote").text
    student[:bio] = profile_page.css("div.bio-content p").text
    student
  end

end
