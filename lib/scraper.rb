require 'open-uri'
require 'pry'
require_relative "./student.rb"

class Scraper

  def self.scrape_index_page(index_url)
       
      students_array = []
  
      html = open(index_url)
      doc = Nokogiri::HTML(html)
      
     doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_link = "#{student.attr('href')}"
        student_name = student.css('.student-name').text
        student_location =  student.css('.student-location').text 
        new_hash = {
          :name => student_name, 
          :location => student_location,
          :profile_url => student_link
        }
        students_array << new_hash
      end 
    end 
    students_array
  end
   
  def self.scrape_profile_page(profile_url)
    
    student_hash = {
     
    }
    
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
     student_name = doc.xpath("//h1 [@class='profile-name']").text 
     last_name = student_name.split(" ")[1]
     last_name = last_name.downcase 
    all_links = doc.xpath("//a")
     all_links.each do |link|
       if link.attr('href').include?('twitter')
         student_hash[:twitter] = link.attr('href')
       elsif link.attr('href').include?('linkedin')
         student_hash[:linkedin] = link.attr('href')
       elsif link.attr('href').include?('github')
         student_hash[:github] = link.attr('href')
       elsif link.attr('href').include?(last_name)
         student_hash[:blog] = link.attr('href')
       end 
     end 
     bio = doc.xpath("//div [@class='description-holder']/p").text 
     student_hash[:bio] = bio
     profile_quote = doc.xpath("//div [@class='profile-quote']").text 
     student_hash[:profile_quote] = profile_quote
     student_hash
  end 
end 
  