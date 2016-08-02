require 'open-uri'
require 'pry'

class Scraper

  #scraping the index page that lists all of the students
  def self.scrape_index_page(index_url)
    #return array of hashes. each hash represents single student
    #keys of each stud. :name, :location, :profile_url
    index_page = Nokogiri::HTML(open(index_url))
    students = []

    index_page.css("div.roster-cards-container").each do |card|
      card.css("div.student-card").each do |student|
        #binding.pry
        student_name = student.css("h4.student-name").text
        student_location = student.css("p.student-location").text
        student_profile = "./fixtures/student-site/students/#{student_name}.html"
        students << {name: student_name, location: student_location, profile_url: student_profile}
      end
    end
    # index_page.css(".student-card")
    #name > index_page.css(".student-card").first.css(".student-name").text
    #location > index_page.css(".student-card").first.css(".student-location").text
    #profile > index_page.css(".student-card").first.attribute("src").value
    students
  end

  #scraping an individual student's profile page to get further
  #information about that student.
  def self.scrape_profile_page(profile_url)

  end

end
