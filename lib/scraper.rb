require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
    #student_name = html.css(".student-name")
    #location = html.css(".student-location")
#check this below
    #profile_url = html.css(".student-card a").attribute("href").value

    #student hash = array of student name, location and profile url
    #students = hash of student arrays
    students_array = []
    students = html.css(".student-card")
    students.each do |student|
      student = {
        :student_name => students.css("student-name").text,
        :location => students.css("student-location").text,
        :profile_url => students.css(".student-card a").attribute("href").value
      }
      students_array << student
    end
    students_array
    binding.pry
end

  def self.scrape_profile_page(profile_url)

  end
end
