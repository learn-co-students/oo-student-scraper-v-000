require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read('./fixtures/student-site/index.html')
    nokified= Nokogiri::HTML(html) 
      scraped_students = []
        nokified.css("div.student-card").each do |student|  
          scraped_students << {:name => student.css("h4.student-name").text , :location => student.css("p.student-location").text ,:profile_url => "#{student.css("a").attribute("href").value}"}
        end 
        scraped_students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read('./fixtures/student-site/students/ryan-johnson.html')   
    nokified = Nokogiri::HTML(html)
    
    
    
    c = nokified.css(".social-icon-container").children.css("a").map { |smelement| smelement.attribute("href").value}
  

    scraped_student = {:twitter => c[0], :linkedin => c[1], :github => c[2], :blog => c[3], 
    
    :profile_quote => nokified.css("div.profile-quote").text , :bio => nokified.css("div.description-holder p").text }
    # # twitter url, linkedin url, github url, blog url, profile #quote, and bio
    #array 
    binding.pry
  end 

end

