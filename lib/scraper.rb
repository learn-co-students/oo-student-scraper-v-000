require 'open-uri'
require 'pry'

class Scraper
  
  attr_accessor :name, :location, :profile_url
  
 

  def self.scrape_index_page(index_url)
    html = open(index_url)
    # html = open('./fixtures/student-site/index.html')
    index_page = Nokogiri::HTML(html)
    # binding.pry
    
    students = []
    
    index_page.css('.student-card a').map do |student|
     
    
     name = student.css('h4').text
     page_url = student.attribute('href').value
     location = student.css('p').text
      
      name = {:name =>  name, :location => location , :profile_url => page_url}
      
      students << name
    
    end
  # binding.pry
    students
  end

  def self.scrape_profile_page(profile_url)
    
  end

end


