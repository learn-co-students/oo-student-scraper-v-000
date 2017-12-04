require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
#is a class method that scrapes the student index page ('./fixtures/student-site/index.html') and a returns an array of hashes in which each hash represents one student
  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    students_index = Nokogiri::HTML(html)
    #binding.pry
    students = []
      students_index.css("div.student-card").each do |student_card|
        #name = student_card.css("h4.student-name").text #NOT a hash of hashes like kickstarter, just an array
        #binding.pry
        students << {
          :name => student_card.css("h4.student-name").text,
          :location => student_card.css("p.student-location").text,
          #:profile_url => "fixtures/student-site/#{student_card.css("a").attribute("href").text}" works for all but 3 for some reason, per zoom save the path fix for the usage end
          :profile_url => student_card.css("a").attribute("href").text
        }
        #binding.pry
      end
    students
  end #self.scrape_index_page


#is a class method that scrapes a student's profile page and returns a hash of attributes describing an individual student
#can handle profile pages without all of the social links
  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    student_scrape = Nokogiri::HTML(html)
    output = {}
    output[:profile_quote] = student.scrape.css("div.profile-quote")
    #binding.pry

    output = {
      :twitter => student_scrape.css().text
      :linkedin => student_scrape.css().text
      :github => student_scrape.css().text
      :blog => student_scrape.css().text
      :profile_quote => student_scrape.css().text
      :bio => student_scrape.css("div.socal-icon").text
    }
    #binding.pry
    output
  end #self.scrape_profile_page

end #SCRAPER CLASS
