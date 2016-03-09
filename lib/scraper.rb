
require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

   def get_profile
   
   end

  def self.scrape_index_page(index_url)
    student_hash = []
    page =  Nokogiri::HTML(open(index_url))

    page.css("div.student-card").each do |des|
      student = {name: des.css("h4.student-name").text, 
        location: des.css("p.student-location").text,
        profile_url: "#{"http://127.0.0.1:4000/"}" + des.css("a").attribute("href"),
      }
      student_hash << student
      end
      student_hash
  end

  def self.scrape_profile_page(profile_url)
        page = Nokogiri::HTML(open(profile_url))
     student_hash = {:profile_quote => page.search("div.profile-quote").text,
                        :bio => page.search("div.description-holder p").text
                      }
 
     page.search("div.social-icon-container a").each do |link|
       url = link.attribute("href").value
 
       if url.include?("twitter")
         student_hash[:twitter] = url
       elsif url.include?("linkedin")
         student_hash[:linkedin] = url
       elsif url.include?("github")
         student_hash[:github] = url
       else
         student_hash[:blog] = url
       end
     end
     student_hash
   end
    
  end



