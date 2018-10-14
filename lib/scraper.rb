require 'open-uri'
require 'pry'
require_relative "./student.rb"

class Scraper

  def self.scrape_index_page(index_url)
       
      students_array = []
  
      html = open(index_url)
      doc = Nokogiri::HTML(html)
      student_cards = doc.css(".student-card")
      
      student_cards.each do |card|
         student_name = card.css(".student-name").text 
         student_location = card.css(".student-location").text 
         first_name = student_name.split(" ")[0].downcase
         last_name = student_name.split(" ")[1].downcase 
         student_url = "students/#{first_name}-#{last_name}.html"
         new_hash = {
           :name => student_name,
           :location => student_location,
           :profile_url => student_url 
         } 
         
         #students_array.push(new_hash)
        binding.pry 
          end 
      

  end
   
  def self.scrape_profile_page(profile_url)
    
 end

end

