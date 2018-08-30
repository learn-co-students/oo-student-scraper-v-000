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
    profile_page = Nokogiri::HTML(File.read(profile_url))
    
    students_profile = {}
    profile_page.css("div.vitals-container").each do |student_info|
      urls = []
      student_info.css("a").attribute("href").value.map {|url| urls << url}
      twitter_info = student_info.css("a").attribute("href").value 
      binding.pry
    # <div class="vitals-container">
    #     <div class="profile-photo" id="ryan-johnson-card"></div>
    #     <div class="social-icon-container">
    #       <a href="https://twitter.com/empireofryan"><img class="social-icon" src="../assets/img/twitter-icon.png"></a>
    #       <a href="https://www.linkedin.com/in/ryan-johnson-321629ab"><img class="social-icon" src="../assets/img/linkedin-icon.png"></a>
    #       <a href="https://github.com/empireofryan"><img class="social-icon" src="../assets/img/github-icon.png"></a>
    #       <a href="https://www.youtube.com/watch?v=C22ufOqDyaE"><img class="social-icon" src="../assets/img/rss-icon.png"></a>
    #     </div>
    #     <div class="vitals-text-container">
    #       <h1 class="profile-name">Ryan Johnson</h1>
    #       <h2 class="profile-location">New York, NY</h2>
    #       <div class="profile-quote">"The mind is everything. What we think we become." - Buddha</div>
    #     </div>
    #   </div>
    end
  end

end
  end

end