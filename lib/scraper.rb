require 'open-uri'
require 'nokogiri'
require 'pry'


class Scraper
    attr_accessor :parse_page
 
  def initialize 
    doc = open-uri.get("./fixtures/student-site/index.html")
    @parse_page = Nokogiri::HTML(html)  
  end 

  names = parse_page.css()
  
  def self.scrape_index_page(index_url)
    {:name => <h4 class, :location => <p class, :student_url => <a href}
    
    #<h4 class="student-name">Ryan Johnson</h4>   Name
    #<p class="student-location">Glenelg, MD</p>  Location
    #<a href="students/eric-chu.html">          Student-url
              
                     
    
    scraped_students = [] 
    @student = student
    @@all << self
    index_url = "./fixtures/student-site/index.html"
    html = open(https://flatironschool.com)
    
    
  end

end 
  
  
  # def self.scrape_profile_page(profile_url)
    
  
  # end



