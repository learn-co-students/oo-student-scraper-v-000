require 'open-uri'
require 'pry'
require 'nokogiri'
class Scraper

  def self.scrape_index_page(index_url)
    info_array=[]
    info_hash={}
    doc=Nokogiri::HTML(open(index_url))
    info= doc.css(".roster-cards-container .card-text-container")
    info.each do |stuff|
        info_hash = {:name => stuff.css(".student-name").text, :location => stuff.css(".student-location").text}
        info_array << info_hash
    end
 
    info = doc.css(".roster-cards-container .student-card")
    add_http ="http://127.0.0.1:4000/"
    info.each_with_index do |stuff, i|
      info_array[i][:profile_url] =   "#{add_http}#{stuff.css("a").attribute("href").value}"
    end
      
    info_array
  end
  

  def self.scrape_profile_page(profile_url)
    student_hash={:twitter=>"", :linkedin=>"", :github=>"",:blog=>"",:profile_quote=>"", :bio=>""}
  
    doc=Nokogiri::HTML(open(profile_url))
    
    student_hash[:twitter]=doc.css(".social-icon-container a").attribute("href").value
  
    student_hash[:linkedin]=doc.css(".social-icon-container a:nth-child(2)").attribute("href").value
    student_hash[:github]=doc.css(".social-icon-container a:nth-child(3)")#.attribute("href").value
    student_hash[:blog]=doc.css(".social-icon-container a:nth-child(4)").attribute("href").value
  
    
    student_hash[:bio]=doc.css(".description-holder p").text
    student_hash[:profile_quote]=doc.css(".profile-quote").text
    student_hash
   


  end

  

end


info=Scraper.scrape_index_page("http://127.0.0.1:4000/")
    puts info

                                      
# doc=Scraper.scrape_profile_page("http://127.0.0.1:4000/students/david-kim.html")
#       puts doc






