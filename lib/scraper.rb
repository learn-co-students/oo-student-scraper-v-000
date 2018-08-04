require 'open-uri'
require 'pry'

class Scraper

def self.scrape_index_page(index_url)
    students = []
    
    html = open("./fixtures/student-site/index.html")
    doc = Nokogiri::HTML(html)
    
    doc.css(".student-card").each do |student_card|
      name = student_card.css("h4.student-name").text
      location = student_card.css("p.student-location").text
      url = student_card.css("a").attribute("href").value
      students << {:name => name, :location => location, :profile_url => url}
    end
    students
  end	  

  def self.scrape_profile_page(profile_url)
    individual_student_profile = {}
    
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    
    student_websites = doc.css(".social-icon-container a").collect {|website| website.attribute("href").value}
    
    student_websites.each do |url| 
      if url.include?("twitter")
        individual_student_profile[:twitter] = url
      elsif url.include?("linkedin") 
        individual_student_profile[:linkedin] = url  
      elsif url.include?("github") 
        individual_student_profile[:github] = url  
      else individual_student_profile[:blog] = url 
      end 
      individual_student_profile[:profile_quote] = doc.css(".profile-quote").text
      individual_student_profile[:bio] = doc.css(".bio-block .bio-content .description-holder p").text
    end 
    individual_student_profile 
  end

end

