require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    scraped_students = []

    index_page.css("div.roster-cards-container").each do |cards| # div .roster-cards-container .student-card .card-text-container h4.student-name
      cards.css(".student-card a").each do |student|
        student_profile = "#{student.attr('href')}"
        student_location = student.css(".student-location").text
        student_name = student.css(".student-name").text
        scraped_students << {name: student_name, location: student_location, profile_url: student_profile}
      end
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    scraped_profile = {}

    links = profile_page.css(".social-icon-container").children.css("a").map do |element|
        element.attribute("href").value
    end
    twitter = links[0]
    linkedin = links[1]
    github = links[2]
    blog = links[3]

   #scraped_profile
 end

end

# go into div .main-wrapper profile - returned 0 DONT USE
# div .vitals-container = 0 div .social-icon-container a - social links
# div .details-container div .bio-block details-block - contains bio
# div .bio-content content-holder div .description-holder - for bio text
