require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    student_profiles = Nokogiri::HTML(html)
    
    profiles = []
    student = {}
    
    student_profiles.css("div.student-card").each {|student|
      students = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    profiles << students
      }
    profiles
  end


  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    one_student_profile = Nokogiri::HTML(html)
    
    student = {}
    
    links = one_student_profile.css("div.social-icon-container").children.css("a").collect {|element| element.attribute("href").value}
      links.each do |link|
        if link.include?("twitter")
          student[:twitter] = link
        elsif link.include?("linkedin")
          student[:linkedin] = link
        elsif link.include?("github")
          student[:github] = link
        else
          student[:blog] = link
        end
      end
      
      student[:profile_quote] = one_student_profile.css(".profile-quote").text
      student[:bio] = one_student_profile.css("div.description-holder p").text
      
    student
    
  end

end

