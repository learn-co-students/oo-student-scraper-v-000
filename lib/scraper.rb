require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  index_url = 'fixtures/student-site/index.html'

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    roster = Nokogiri::HTML(html)
    students = {}
    i = 1
    #roster.css(".roster-cards-container").each do |student|
    roster.css(".student-card").each do |student|
      student_header = i#student.css("div.id").text
      #binding.pry
      students[student_header] = {
        :name => student.css("h4").text,
        :location => student.css("p").text,
        :profile_url => student.css("a").attribute("href").value
      }
      i+=1
    end
    students
    #binding.pry
  end

  def self.scrape_profile_page(profile_url)
    #This is a class method that should take in an argument of a student's profile URL. It should use
    #Nokogiri and Open-URI to access that page. The return value of this method should be a hash in which
    #the key/value pairs describe an individual student. Some students don't have a twitter or some other
    #social link. Be sure to be able to handle that.
    #twitter url, linkedin, gituhub url, blog url, profile quote, bio
    html = File.read(profile_url)
    roster = Nokogiri::HTML(html)
    profile = {}
    i = 1
    #roster.css(".roster-cards-container").each do |student|
    #roster.css(".student-card").each do |student|
      #student_header = i#student.css("div.id").text
      #binding.pry
      profile = {
        :twitter => ,
        :linkedin => ,
        :github => ,
        :blog => ,
        :profile_quote => ,
        :bio => 
        binding.pry
      }
      #i+=1
    end
    profile
    #binding.pry
  end

end
Scraper.scrape_profile_page('./fixtures/student-site/students/ryan-johnson.html')
