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
    student_hash={}
  
    doc=Nokogiri::HTML(open(profile_url))
      profile_links = doc.css("a").select{|link| link['href']}
      profile_links.each do |link| 
        if link['href'].include?("linkedin")
          student_hash[:linkedin]=link['href']
        end
        if link['href'].include?("twitter")
          student_hash[:twitter]=link['href']
        end
        if link['href'].include?("http:")
           student_hash[:blog]=link['href']
        end
       if link['href'].include?("github")
        student_hash[:github]=link['href']
        end
      end

     student_hash[:profile_quote]=doc.css(".profile-quote").text
     student_hash[:bio]=doc.css(".description-holder p").text
   student_hash
  end

end





