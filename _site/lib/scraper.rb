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
#   end  =====> New York, NY etc...


#------- location ------->
#  student_index.css('div.roster-cards-container a').each do |card|
#   card.css('div.card-text-container').each do |student|       
#     puts student.css('p.student-location').text
#     end
#   end  =====> Ryan Johnson etc...

#student_url = student_index.css('.student-card a')[1]['href'] 
#   => "students/eric-chu.html" 

  def self.scrape_index_page(index_url)
    scraped_students = []
    student_index = Nokogiri::HTML(open(index_url))
    student_index.css("div.roster-cards-container").each do |card|
      card.css('.student-card a').each do |student|
        student_url = "http://127.0.0.1:4000/#{student['href']}"
        card.css("div.card-text-container").each do |student|
          student_name = student.css("h4.student-name").text
          student_location = student.css("p.student-location").text
          scraped_students << {name: student_name, location: student_location, profile_url: student_url}
        end
      end
    end
    scraped_students
  end  #------ scrape index page -------->

  def self.scrape_profile_page(profile_url)
    scraped_student = {}
    social_links = []
    student_profile = Nokogiri::HTML(open(profile_url))

    student_profile.css('.social-icon-container a').each do |social|
      social_links << social['href']
    end

    social_links.each do |site|
      if site.include?("twitter")
        scraped_student[:twitter] = site
      elsif site.include?("linkedin")
        scraped_student[:linkedin] = site
      elsif site.include?("github")
        scraped_student[:github] = site
      else
        scraped_student[:blog] = site
      end
    end

    scraped_student[:profile_quote] = student_profile.css('.profile-quote').text
    scraped_student[:bio] = student_profile.css('.description-holder p').text

    scraped_student

  end #-------- scrape profile page ---------->



end
