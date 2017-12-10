require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  @student_info_hash_array = []

  def self.scrape_index_page(index_url)    
    web_page = Nokogiri::HTML(open(index_url))

    web_page.css("div.student-card").each do |student| 
      
      student_info_hash = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a.href").text
      }
      @student_info_hash_array << student_info_hash
    end
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

# scrape information from index and instantiate students

# => {:name => "Abby Smith", :location => "Brooklyn, NY", :profile_url => "students/abby-smith.html"}



# <div class="card-text-container">
# <h4 class="student-name">Ryan Johnson</h4>
# <p class="student-location">New York, NY</p>
# </div>

  # kickstarter.css("li.project.grid_4").each do |project|
  #   title = project.css("h2.bbcard_name strong a").text
  #   projects[title.to_sym] = {
  #     :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
  #     :description => project.css("p.bbcard_blurb").text,
  #     :location => project.css("ul.project-meta span.location-name").text,
  #     :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
  #   }