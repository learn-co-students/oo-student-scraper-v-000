require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read('./fixtures/student-site/index.html')
    learn_co = Nokogiri::HTML(html)

    students = []
    
    learn_co.css(".student-card").each do |student|
      students << {
      :name => student.css("a .card-text-container h4.student-name").text,
      :location => student.css("a .card-text-container p.student-location").text,
      :profile_url => "./fixtures/student-site/#{student.css("a").attribute("href").value}"
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    student_page = Nokogiri::HTML(html)
    
    social_links = student_page.css(".social-icon-container a")

    student_info = {}

    social_links.each do |link|
      if link["href"].include?("twitter")
        student_info[:twitter] = link["href"]
      elsif link["href"].include?("linkedin")
        student_info[:linkedin] = link["href"]
      elsif link["href"].include?("github")
        student_info[:github] = link["href"]
      else
        student_info[:blog] = link["href"]
      end
    end

    student_info[:profile_quote] = student_page.css(".profile-quote").text
    student_info[:bio] = student_page.css(".description-holder p").text

    student_info
  end
  
end

