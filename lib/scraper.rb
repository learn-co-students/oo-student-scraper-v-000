require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    site = Nokogiri::HTML(open(index_url))
    scraped_students = []
    
    scraped_students = site.css(".student-card").collect do |student|
      {
        :name => student.css("div.card-text-container h4.student-name").text,
        :location => student.css("div.card-text-container p.student-location").text,
        :profile_url => "http://127.0.0.1:4000/" + student.css("a").attribute("href").value
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    site = Nokogiri::HTML(open(profile_url))
    student_profile = {}

    links = site.css("div.social-icon-container a").map do |link|
      link.attribute("href").value
    end

    links.map do |link|
      if link.include?("twitter")
        student_profile[:twitter] = link
      elsif link.include?("linkedin")
        student_profile[:linkedin] = link
      elsif link.include?("github")
        student_profile[:github] = link
      else
        student_profile[:blog] = link
      end
    end  
    
    student_profile[:profile_quote] = site.css(".profile-quote").text
    student_profile[:bio] = site.css(".description-holder p").text
    student_profile
  end

end