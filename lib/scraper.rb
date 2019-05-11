require_relative "../lib/student.rb"
require 'open-uri'
require 'pry'

class Scraper

# index_url = '.fixtures/student-site.index.html'
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(File.read(index_url))

    students_array = []
# [# {:name => "Abby Smith", :location => "Brooklyn, NY",
# :profile_url => "students/abby-smith.html"} ]

    index.css("div.roster-cards-container.student_card").each do |student_card|
      students_array << 

  def self.scrape_profile_page(BASE_PATH + student.profile_url)


    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)

  end
end
