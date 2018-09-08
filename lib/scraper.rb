require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    scraped_students = []
    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_profile_link = student.attr('href')
        student_location = student.css('.student-location').text
        student_name = student.css('.student-name').text
        scraped_students << {name: student_name, location: student_location, profile_url: student_profile_link}
       end
     end
    scraped_students
   end

   def self.scrape_profile_page(profile_url)
     profile_doc = Nokogiri::HTML(open(profile_url))
     attributes = {}
     profile_doc.css("div.social-icon-container a").each do |link|
       case link.attribute("href").value
       when /twitter/
         attributes[:twitter] = link.attribute("href").value
       when /github/
         attributes[:github] = link.attribute("href").value
       when /linkedin/
         attributes[:linkedin] = link.attribute("href").value
       else
           attributes[:blog] = link.attribute("href").value
       end
     end
     attributes[:profile_quote] = profile_doc.css("div.profile-quote").text
     attributes[:bio] = profile_doc.css("div.bio-content div.description-holder").text.strip
     attributes
   end
 end
