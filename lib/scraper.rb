require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))

    scraped_students = []
    # index_page.css("div.student-card a div.card-text-container h4.student-name").first.text
    # => "Ryan Johnson"
    # index_page.css("div.student-card a div.card-text-container p.student-location").first.text
    # => "New York, NY"
    # index_page.css("div.student-card a").first.attribute("href").value
    # => "students/ryan-johnson.html"

    index_page.css("div.roster-cards-container").each do |card|
      card.css("div.student-card a").each do |student|
        student_location = student.css("div.card-text-container p.student-location").text
        student_profile_link = ".fixtures/student-site/#{student.attr('href')}"
        student_name = student.css("div.card-text-container h4.student-name").text
      scraped_students << {:name => student_name, :location => student_location, :profile_url => student_profile_link}
      end
    end
    scraped_students
  end



  def self.scrape_profile_page(profile_url)
    
  end

end

#   def self.scrape_index_page(index_url)
#     index_page = Nokogiri::HTML(open(index_url))

#     scraped_students = []
#     # index_page.css("div.student-card a div.card-text-container h4.student-name").first.text
#     # => "Ryan Johnson"
#     # index_page.css("div.student-card a div.card-text-container p.student-location").first.text
#     # => "New York, NY"
#     # index_page.css("div.student-card a").first.attribute("href").value
#     # => "students/ryan-johnson.html"

#     index_page.css("div.student-card a").each do |student|
#       student = {
#         :name => student.css("div.card-text-container h4.student-name").text,
#         :location => student.css("div.card-text-container p.student-location").text,
#         :profile_url => student.css.attribute("href").value
#       }
#       scraped_students << student
#     end
#     scraped_students
#   end
