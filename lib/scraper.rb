require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url = "http://127.0.0.1:4000/")
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = []
    student_cards = doc.css(".student-card")
    student_cards.each do |student|
      students << {:name => student.css("h4.student-name").text, :location => student.css("p.student-location").text, :profile_url => index_url + student.css("a").attribute("href").value}
    end
    students  
  end

  
  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student_info = {}
    info = doc.css(".social-icon-container a")
    info.each do |link|
      if link.attribute("href").value.include?("twitter")
        student_info[:twitter] = link.attribute("href").value
      elsif link.attribute("href").value.include?("linkedin")
        student_info[:linkedin] = link.attribute("href").value
      elsif link.attribute("href").value.include?("github")
        student_info[:github] = link.attribute("href").value
      else link.attribute("href").value.include?("blog")
        student_info[:blog] = link.attribute("href").value
      end
    end

    student_info[:profile_quote] = doc.css(".profile-quote").text 
    student_info[:bio] = doc.css(".description-holder p").text 
    student_info
    
  end

end
 
