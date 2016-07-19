require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_students = []
    student_doc = Nokogiri::HTML(open("#{index_url}"))
    student_doc.css(".student-card").collect do |student|
      scraped_students << {
        name: student.search(".student-name").text,
        location: student.search(".student-location").text,
        profile_url: "./fixtures/student-site/#{student.css("a").attribute("href").text}"
      }
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    scraped_student = {}
    links = []
    
    student_doc = Nokogiri::HTML(open("#{profile_url}"))
    student_doc.css("div .social-icon-container a").each do |link|
      links << link["href"]
      
      links.each do |social_link|
        if social_link.include?("twitter")
          scraped_student[:twitter] = social_link
        elsif social_link.include?("linkedin")
          scraped_student[:linkedin] = social_link
        elsif social_link.include?("github")
          scraped_student[:github] = social_link
        else
          scraped_student[:blog] = social_link
        end
        scraped_student[:profile_quote] = student_doc.css(".profile-quote").text
        scraped_student[:bio] = student_doc.css("p").text
      end 
    end
    scraped_student
  end

end
