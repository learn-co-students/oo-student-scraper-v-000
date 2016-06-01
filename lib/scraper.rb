require 'open-uri'
require 'pry'

class Scraper

  # :name
  # :location
  # :profile_url

#------- name and location ------->
#  student_index.css('div.roster-cards-container a').each do |card|
#    puts card.css('div.card-text-container').text               
#  end   ====> Ryan Johnson                                                    
#               New York, NY      etc...


#------- name ------->
#  student_index.css('div.roster-cards-container a').each do |card|
#   card.css('div.card-text-container').each do |student|       
#     puts student.css('h4.student-name').text
#     end
#   end  =====> Ryan Johnson etc...


#------- location ------->
#  student_index.css('div.roster-cards-container a').each do |card|
#   card.css('div.card-text-container').each do |student|       
#     puts student.css('p.student-location').text
#     end
#   end  =====> Ryan Johnson etc...

  def self.scrape_index_page(index_url)
    scraped_students = []
    student_index = Nokogiri::HTML(open(index_url))
    binding.pry
#    student_index.css("div.roster-cards-container").each do |card|
#      card.css("div.student-card a").each do |entry|
#        entry.css("div.card-text-container").map do |student|
#          student_name = student.css("h4.student-name").text
#          student_location = student.css("p.student-location").text
#          scraped_students << {name: student_name, location: student_location}
#        end
#      end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)

  end

end
