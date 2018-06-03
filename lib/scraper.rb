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
        #binding.pry
  end

  def self.scrape_profile_page(profile_url)
    scraped_student = {}
    
    html = File.read(profile_url)   
    nokified = Nokogiri::HTML(html)
    
    c = nokified.css(".social-icon-container").each do |s|
      s.css("a").each do |link|
        if link.attributes["href"].value.include?("linkedin")
          scraped_student[:linkedin] = link.attributes["href"].value
        elsif link.attributes["href"].value.include?("twitter")
          scraped_student[:twitter] = link.attributes["href"].value
        elsif link.attributes["href"].value.include?("github")
          scraped_student[:github] = link.attributes["href"].value
        else
          scraped_student[:blog] = link.attributes["href"].value
        end 
      end
      scraped_student[:bio] = nokified.css("div.description-holder p").text
      scraped_student[:profile_quote] =  nokified.css("div.profile-quote").text
    end
    scraped_student
  end
  
end 
          
        # { |smelement| smelement.attribute("href").value}
    
  
    
    
    # {:twitter => c[0], :linkedin => c[1], :github => c[2], :blog => c[3], 
    
    # :profile_quote => nokified.css("div.profile-quote").text , :bio => nokified.css("div.description-holder p").text }
    # # twitter url, linkedin url, github url, blog url, profile #quote, and bio
    #array 
    #binding.pry
  



