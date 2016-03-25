require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    site = Nokogiri::HTML(index_url)
    student_arr = []

    all_students = site.css("div.roster-cards-container")
    students = all_students.css("div.student-card")
    students.each do |student|
      profile = {
        :name => student.css("div.card-text-container h4.student-name").text,
        :location => student.css("div.card-text-container p.student-location").text,
        :profile_url => student.css("a").attr('href').value
        }
      student_arr << profile
    end
    student_arr
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

#all students: site.css("div.roster-cards-container")
#student: students.css("div.student-card")   #add .first
#:name:  student.css("div.card-text-container h4.student-name").text
#:location: student.css("div.card-text-container p.student-location").text
#:profile_url: student.css('a').attr('href').value

# index_url = File.read('fixtures/student-site/_site/index.html')
# scraped_students = Scraper.scrape_index_page("https://0.0.0.0:4000")
# binding.pry