require 'open-uri'
require 'pry'

class Scraper
  
  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(File.read(index_url))
    
    @scraped_students = []
    
    index_page.css("div.student-card").each do 
      |student_card| 
      
      student_name = student_card.css("h4.student-name").text
      student_location = student_card.css("p.student-location").text
      student_profile = student_card.css("a").attribute("href").value
      @scraped_students << {
        :name => student_name, 
        :location => student_location, 
        :profile_url => student_profile
      }
    end
    @scraped_students
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

# <div class="student-card" id="eric-chu-card">
#   <a href="students/eric-chu.html">
#       <div class="view-profile-div">
#         <h3 class="view-profile-text">View Profile</h3>
#       </div>
#       <div class="card-text-container">
#         <h4 class="student-name">Eric Chu</h4>
#         <p class="student-location">Glenelg, MD</p>
#       </div>
#   </a>
# </div>

