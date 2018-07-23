require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css(".roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_name = student.css("h4.student-name").text
        student_location = student.css("p.student-location").text
        student_profile_link = student.attribute("href").value
        students << {name: student_name, location: student_location, profile_url: student_profile_link}
      end
    end
    students

  end


  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student_data = {}

    student_data = {}
    profile_page.css(".social-icon-container").each do |icon|
      #binding.pry
      if icon.css(".social-icon").attribute("src").value == "../assets/img/twitter-icon.png"
        student_data[:twitter] = icon.attribute("href").value if icon.attribute("href")

      elsif icon.css(".social-icon").attribute("src").value == "../assets/img/linkedin-icon.png"
        student_data[:linkedin] = icon.attribute("href").value if icon.attribute("href")
      elsif icon.css(".social-icon").attribute("src").value == "../assets/img/github-icon.png"
        student_data[:github] = icon.attribute("href").value if icon.attribute("href")
      elsif icon.css(".social-icon").attribute("src").value == "../assets/img/rss-icon.png"
        student_data[:blog] = icon.attribute("href").value if icon.attribute("href")
      end
    end
    student_data[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
    student_data[:bio] = profile_page.css(".details-container p").text if profile_page.css(".details-container p")

    student_data

    end
end
