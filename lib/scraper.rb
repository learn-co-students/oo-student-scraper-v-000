require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url = "./fixtures/student-site/index.html") #responsible for scraping the index page that lists all of the students
    index_page = Nokogiri::HTML (open(index_url))
    scraped_students = [ ]
    binding.pry
    index_page.css("roster-cards-container").each do |card|
      student_hash = {} 
      
      student_hash[:name] = card.css("student-card").css ("card-text-container").css("h4")
      
      student_hash[:location] = card.css("student-card").css ("card-text-container").css("p")
      
      student_hash[:profile_url] = card.css("student-card").css ("card-text-container").css("href")
      
      students.push(student_hash)
      
      
    end
  end

  def self.scrape_profile_page(profile_url) #responsible for scraping an individual student's profile page to get further information about that student.

  end

end

# <div class="roster-cards-container">
#           <div class="student-card" id="ryan-johnson-card">
#             <a href="students/ryan-johnson.html">
#               <div class="view-profile-div">
#                 <h3 class="view-profile-text">View Profile</h3>
#               </div>
#               <div class="card-text-container">
#                 <h4 class="student-name">Ryan Johnson</h4>
#                 <p class="student-location">New York, NY</p>
#               </div>
#             </a>
#           </div>