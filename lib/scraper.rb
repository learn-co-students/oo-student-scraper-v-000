require 'open-uri'
require 'nokogiri'
require 'pry'


class Scraper
    attr_accessor :parse_page

  def initialize 
    doc = open-uri.get("./fixtures/student-site/index.html")
    @parse_page = Nokogiri::HTML(html)  
  end 

  # names = parse_page.css()
  # location = parse_page.css()
  # profile_url = parse_page.css()

  def self.scrape_index_page(index_url)
    something.css(name, location, profile_url).something.map
    
  end
    
    {:name => <h4 class, 
    :location => <p class, 
    :student_url => <a href}

     
    
                   
    
    scraped_students = [] 
    @student = student
    @@all << self
    index_url = "./fixtures/student-site/index.html"
    
    html = open(https://flatironschool.com)
    
    
  end

end 
  
  
  # def self.scrape_profile_page(profile_url)
    
  
  # end



