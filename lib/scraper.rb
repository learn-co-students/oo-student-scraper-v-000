require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_students = Array.new

    html = open(index_url)
    students = Nokogiri::HTML(html)

    students.css(".student-card").each do |s|
      student_name = s.css("h4.student-name").text
      student_location = s.css("p.student-location").text
      profile_url = "./fixtures/student-site/#{s.css("a").attr("href").text}"

      scraped_students << {name: student_name, location: student_location, profile_url: profile_url}
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    scraped_student = {}

    html = open(profile_url)
    profile = Nokogiri::HTML(html)

    profile.css(".vitals-container").each do |info|
      info.css(".social-icon-container a").each do |nested_info|

        if nested_info.attr("href").include?("twitter")
          scraped_student[:twitter] = nested_info.attr("href")
        end

        if nested_info.attr("href").include?("linkedin")
          scraped_student[:linkedin] = nested_info.attr("href")
        end

        if nested_info.attr("href").include?("github")
          scraped_student[:github] = nested_info.attr("href")
        end

        if nested_info.attr("href").include?("flatiron")
          scraped_student[:blog] = nested_info.attr("href")
        end

        scraped_student[:profile_quote] = info.css(".vitals-text-container .profile-quote").text
      end
    end
    
    profile.css(".details-container").each do |info|
      bio = info.css(".description-holder p").text
      scraped_student[:bio] = bio
    end

  scraped_student
  end

end
