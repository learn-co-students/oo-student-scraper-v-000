require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  @@scraped_students = []
 
  def self.scrape_index_page(index_url)
    html = File.read('./fixtures/student-site/index.html')
    student_page = Nokogiri::HTML(html)
    
    scraped_students = []
    
    student_page.css("div.student-card").each do |student|
      student_hash = {
      :name => student.css("a h4.student-name").text,
      :location => student.css("a p.student-location").text,
      :profile_url => student.css("a").attribute("href").value
      }
      scraped_students << student_hash
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    profile = File.read(profile_url)
    student_profile = Nokogiri::HTML(profile)
    scraped_student = {}
    
    links = student_profile.css("div.social-icon-container a").map {|x| x.attribute("href").value}
        
        # site_link = link.css("a"
        links.each do |site_link|
        if site_link.include?("github")
          scraped_student[:github] = site_link
        elsif site_link.include?("twitter")
          scraped_student[:twitter] = site_link
        elsif site_link.include?("linkedin")
          scraped_student[:linkedin] = site_link
        else
          scraped_student[:blog] = site_link
        end 
      end 
      scraped_student[:profile_quote] = student_profile.css("div.profile-quote").text
      scraped_student[:bio] = student_profile.css("div.details-container div.bio-block.details-block div.bio-content.content-holder p").text
      scraped_student
  end

end

