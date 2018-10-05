require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_index_page(url)
    html = File.read(url)
    index = Nokogiri::HTML(html)
    students = {}
    array = []
    index.css('div.student-card').each {|student|
    students = {
    :name => student.css('h4.student-name').text,
    :location => student.css("p.student-location").text,
    :profile_url => student.css('a').first['href']
      }
      array << students
      }
    array
  end


   def self.scrape_profile_page(profile_url)
    student = {}
    profile_page = Nokogiri::HTML(profile_url)
       binding.pry
    links = profile_page.css('div.social-icons-container')

   end

 end