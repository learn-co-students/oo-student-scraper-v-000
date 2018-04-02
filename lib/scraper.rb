require 'open-uri'
require 'pry'
require 'nokogiri'

#      <div class="student-card" id="aaron-enser-card">
#        <a href="students/aaron-enser.html">
#          <div class="view-profile-div">
#            <h3 class="view-profile-text">View Profile</h3>
#          </div>
#          <div class="card-text-container">
#            <h4 class="student-name">Aaron Enser</h4>
#            <p class="student-location">Scottsdale, AZ</p>
#          </div>
#        </a>
#      </div>

class Scraper
# Responsible for scraping the index page that lists all of the students.
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_card = doc.css(".student-card")
# Scrapes individual student data from copy of index page and returns an array of hashes in which each hash represents a single student.
    students = []
    student_card.each do |card|
      student_name = card.css(".student-name").text
      student_location = card.css(".student-location").text
      student_profile_url = card.css("a").attr("href").text
      students << {name: student_name, location: student_location, profile_url: student_profile_url}
    end
    students
  end

# Responsible for scraping an individual student's profile page to get further information about that student.
  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    # Scrapes copy of student profile page and returns an hash of attributes describing the individual student.
    doc.css(".social-icon-container").children.css("a").each do |link|
      if link.attr("href").include?("twitter")
        student[:twitter] = link.attr("href")
      elsif link.attr("href").include?("linkedin")
        student[:linkedin] = link.attr("href")
      elsif link.attr("href").include?("github")
        student[:github] = link.attr("href")
      else
        student[:blog] = link.attr("href")
      end
    end
    student[:profile_quote] = doc.css(".profile-quote").text
    student[:bio] = doc.css(".description-holder p").text
    student
  end

end
