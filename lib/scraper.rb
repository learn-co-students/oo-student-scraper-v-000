require 'open-uri'
require 'pry'
require 'nokogiri'



class Scraper

  def self.scrape_index_page(index_url)
     #Scrapes URL passed in
     doc = Nokogiri::HTML(open(index_url))

     #Creates student array  to store hash
     students = []

     #Enters into container holding student cards
     doc.css("div.student-card").each do|student|
         #Saves student link, location, and name
         student_link = student.css("a").attr("href").text
         student_name = student.css("h4").text
         student_location = student.css("p").text
         #Puts those saved variables into hash, and saves into student array
         students << {name: student_name, location: student_location, profile_url: student_link}
     end
     #Returns student array
    students
   end



   def self.scrape_profile_page(profile_url)
     #Scrapes URL passed in
     profile = Nokogiri::HTML(open(profile_url))
     #prolife_links is a variable that equals to the container that stores the profile links of each profile
     profile_links = profile.css("div.social-icon-container a").collect do |link|
       link.attr("href")
     end
     #detect  link and checks if it includes the arg(keyword)
     profile_hash = {
       :twitter => profile_links.detect{|link| link.include?('twitter')},
       :linkedin => profile_links.detect{|link| link.include?('linkedin')},
       :github => profile_links.detect{|link| link.include?('github')},
       :blog => profile_links.detect{|link| !link.include?('twitter') && !link.include?('linkedin') && !link.include?('github')},
       :profile_quote => profile.css("div.profile-quote").text,
       :bio => profile.css("div.bio-content p").text
     }
     profile_hash.delete_if{|k,v| v.nil?}
     #removing empty elements from hash
   end


 end
