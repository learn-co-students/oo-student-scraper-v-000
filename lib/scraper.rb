require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    student_hash = {}
    students = []
      doc.css(".student-card").each do |x|
      student_hash = {
        :name => x.css("h4").text,
        :location => x.css("p").text,
        :profile_url => x.css("a").attr("href").value
      }
       students << student_hash
        end
      students
    end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_profile = {}
     x= doc.css(".social-icon-container a").map {|x| x.attr("href")}
     x.each do |social|
       #binding.pry
      if social.include?("twitter")
      student_profile[:twitter] = social
      
      elsif social.include?("linkedin")
      student_profile[:linkedin] = social
       
      elsif social.include?("github")
      student_profile[:github] = social
      
      else
        student_profile[:blog] = social
      end
     end 
      student_profile[:profile_quote] = doc.css(".profile-quote").text
      student_profile[:bio] = doc.css(".description-holder p").text.gsub(/\s+/, " ").strip
        
     
  
    # student_profile = {
    #   :twitter=> doc.css(".social-icon-container a").attr("href").value,
    #   :linkedin=> doc.css(".social-icon-container a")[1]['href'],
    #   :github=> doc.css(".social-icon-container a")[2]['href'],
      
    # }
   
    student_profile 
  end

end
