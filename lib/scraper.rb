require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open("http://localhost:8080/code/labs/oo-student-scraper-v-000/fixtures/student-site/"))

    students = []

    index_page.css(".roster-cards-container").each do |student_card|
      student_card.css(".student-card a").each do |student|
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        student_profile_url = "#{student.attr("href")}"
        students << {name: student_name, location: student_location, profile_url: student_profile_url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))

    student_profile = {}

    profile_page.css(".social-icon-container a").map do |link|
      if link["href"] != "#"
        capture = link["href"].match(/https?:\/{2}w{3}?\.?([a-z]+)/).captures
        case capture[0]
        when "github"
          student_profile[:github] = link["href"]
        when "linkedin"
          student_profile[:linkedin] = link["href"]
        when "twitter"
          student_profile[:twitter] = link["href"]
        else
          student_profile[:blog] = link["href"]
        end
      end
      end

    student_profile[:profile_quote] = profile_page.css(".profile-quote").text

    student_profile[:bio] = profile_page.css(".description-holder p").text

    student_profile
  end

end
