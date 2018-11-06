require 'open-uri'
require 'pry'

class Scraper
  
  def self.scrape_index_page(index_url)
    html = open(index_url)
    parsed_page = Nokogiri::HTML(html)
    all_students = parsed_page.css('div.student-card')
    
    all_students.collect do |student_card|
      #binding.pry
      student = {
        :name => student_card.css('h4.student-name').text,
        :location => student_card.css('p.student-location').text,
        :profile_url => student_card.css('a').attr('href').value
      }
      student
    end
  end
  
      

  def self.scrape_profile_page(profile_url)
    #=> attributes needed: twitter, linkedin, github, blog, profile quote, bio
    #=> responsible for scraping an individual student's profile page to get further info about that student
    html = open(profile_url)
    parsed_page = Nokogiri::HTML(html)
    student = {
      :linkedin => 
      :github =>
      :blog =>
      :profile_quote =>
      :bio =>
    }
    
  end

end



    

