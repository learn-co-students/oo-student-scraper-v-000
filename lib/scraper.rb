require 'open-uri'
require 'pry'
require 'nokogiri'
 
 class Scraper

  def self.scrape_index_page(index_url)
  doc = Nokogiri::HTML(open(index_url))
   students = []
   
   
      doc.css(".student-card").each do |student|
        name = student.css(".student-name").text
        location = student.css(".student-location").text
        profile_url = "#{index_url}#{student.css("a").attribute("href").value}"
       
    students << {:name => name, :location => location, :profile_url => profile_url}
   
     
    end
    students
     
 end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
     students = {}
   doc.css(".social-icon-container a").each do |student_url|
    
      
        if student_url["href"].match("twitter")
          students[:twitter] = student_url["href"]
         
          elsif student_url["href"].match("linkedin")
          students[:linkedin] = student_url["href"]
          elsif student_url["href"].match("github")
          students[:github] = student_url["href"]
        elsif student_url["href"].match("http")
           students[:blog] = student_url["href"]
         

         end
       students[:profile_quote] = doc.css(".profile-quote").text
       students[:bio] = doc.css(".description-holder p").text
     end
     students
  end
end

