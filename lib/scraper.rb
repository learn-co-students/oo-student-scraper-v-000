require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)

    student_index = Nokogiri::HTML(html)
    students = []

    student_index.css(".student-card").each do |student|
      students << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)

    student_profile = Nokogiri::HTML(html)
    profile_info = {}

    links = student_profile.css(".social-icon-container").children.css("a").collect{|link| link.attribute("href").value}.each{ |link|
      if link.include?("twitter")
        profile_info[:twitter] = link
      elsif link.include?("github")
        profile_info[:github] = link
      elsif link.include?("linkedin")
        profile_info[:linkedin] = link
      else
        profile_info[:blog] = link
      end
    }
    profile_info[:bio] = student_profile.css(".description-holder p").text
    profile_info[:profile_quote] = student_profile.css(".profile-quote").text
    profile_info


  end

end
