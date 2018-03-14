require 'open-uri'
require 'pry'

#learn how that student.attr works. 1st job today
class Scraper
# students: student_page.css(".roster-cards-container") - returns all cards
# cards: student_page.css(".student-card a") - returns all cards
# name: student_page.css(".card-text-container h4.student-name").text - returns all names
# location: student_page.css(".card-text-container p.student-location").text - returns all places for every student  
# profile_url:  "./fixtures/student-site/#{student.attr('href')}" 
  def self.scrape_index_page(index_url)
    student_page = Nokogiri::HTML(open(index_url))
    students = []
    
    
    student_page.css("div.roster-cards-container").each do |all_student|
      all_student.css(".student-card a").each do |student|
        student_url = "./fixtures/student-site/#{student.attr('href')}"
        student_name = student.css(".card-text-container h4.student-name").text
        student_location = student.css(".card-text-container p.student-location").text
        students << {:name => student_name, 
                     :location => student_location, 
                     :profile_url => student_url
                    }
      end   
    end 
   students
  end
# all social media links: profile_page.css("div.vitals-container div.social-icon-container a")
  # profile_quote: profile_page.css("div.vitals-container div.vitals-text-container div.profile-quote").text
  # bio: profile_page.css("div.details-container div.bio-block.details-block  div.bio-content.content-holder div.description-holder p").text
  def self.scrape_profile_page(profile_url)
    students = {}
    social_links = []
    profile_page = Nokogiri::HTML(open(profile_url))
    profile_page.css("div.vitals-container div.social-icon-container a").each do |link|
    social_links << link
      social_links.collect do |link|
        if link.attr('href').include?("twitter")
          students[:twitter] = link.attr('href')
        elsif link.attr('href').include?("linkedin")
          students[:linkedin] = link.attr('href')
        elsif link.attr('href').include?("github")
          students[:github] = link.attr('href')
        elsif link.attr('href') =~ /(\S+\.(com|net|org|edu|gov)(\/\S+)?)/
          students[:blog] = link.attr('href')     
        end
      end
    end
    students[:profile_quote] = profile_page.css("div.vitals-container div.vitals-text-container div.profile-quote").text
    students[:bio] = profile_page.css("div.details-container div.bio-block.details-block  div.bio-content.content-holder div.description-holder p").text          
    students 
  end
end              
  