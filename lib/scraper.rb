require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
      html = File.read(index_url)
      student_page = Nokogiri::HTML(html)
      students = []
      student_page.css(".student-card").each { |student|
      students << {
          :name => student.css(".student-name").text,
          :location => student.css(".student-location").text,
          :profile_url => student.css("a").attribute("href").value
        }
      }
      students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile_page = Nokogiri::HTML(html)
    profile_info = {}
    links = profile_page.css(".social-icon-container").children.css("a").collect {|link|
      link.attribute("href").value}.each{ |link|
        if link.include?("twitter")
          profile_info[:twitter] = link
        elsif link.include?("linkedin")
          profile_info[:linkedin] = link
        elsif link.include?("github")
          profile_info[:github] = link
        else
          profile_info[:blog] = link
        end
      }
    profile_info[:bio] = profile_page.css(".description-holder p").text
    profile_info[:profile_quote] = profile_page.css(".profile-quote").text
    profile_info
  end
end

Scraper.scrape_index_page("./fixtures/student-site/index.html")
