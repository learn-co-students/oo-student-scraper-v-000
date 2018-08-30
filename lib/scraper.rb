require 'open-uri'
require 'pry'

class Scraper
  
  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(File.read(index_url))
    
    
    index_page.css("div.roster-cards-container div.card-text-container").each do |student_attr|
      student_name = student_attr.css("h4.student-name").text
      student_location = student_attr.css("p.student-location").text
      student_profile = student_attr.css("a href")
      binding.pry
      scraped_students << {:name => student_name, :location => student_location, :profile_url => student_profile}
      
      # <a href="students/ryan-johnson.html">
      #         <div class="view-profile-div">
      #           <h3 class="view-profile-text">View Profile</h3>
      #         </div>
      #         <div class="card-text-container">
      #           <h4 class="student-name">Ryan Johnson</h4>
      #           <p class="student-location">New York, NY</p>
      #         </div>
      #       </a>
    
    end
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

