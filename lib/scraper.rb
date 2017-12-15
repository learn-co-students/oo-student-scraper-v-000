require 'open-uri'
require 'nokogiri'
require 'pry'
require 'mechanize'

class Scraper

  @student_info_hash_array = []

  @profile_hash = {}

  def self.scrape_index_page(index_url)    
    web_page = Nokogiri::HTML(open(index_url))

    web_page.css("div.student-card").each do |student| 
      
      student_info_hash = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").text
      }
      @student_info_hash_array << student_info_hash
    end
    @student_info_hash_array
  end
  
  def self.scrape_profile_page(profile_url)
    students = {}
    profile_page = Nokogiri::HTML(open(profile_url))
    
    profile_page.css("div.social-icon-container a").attribute("href").text 

    profile_page.each do |link| 
    
    students[:twitter ] = link


            # => , 
            # :linkedin => student.css("div.social-icon-container a").attribute("href").text,
            # :github => student.css("div.social-icon-container a").attribute("href").text,
            # :blog => student.css("div.social-icon-container a").attribute("href").text,



            # :profile_quote => student.css("div.social-icon-container div.vitals-text-container div.profile-quote").text,  
            # :bio => student.css("div.social-icon-container div.details-container div.bio-content content-holder div.description-holder p").text
          
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