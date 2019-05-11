require_relative "../lib/student.rb"
require 'open-uri'
require 'pry'

class Scraper
 
# index_url = '.fixtures/student-site.index.html'
# top layer page scrape, make student, get these attributes:
# students_array (array of indiv student hashes) = 
#   [{:name => "Abby Smith",:location => "Brooklyn, NY",:profile_url => "students/abby-smith.html"}, 
#    {:name => } ]

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(File.read(index_url))
    students_array = []
  # ?? not iterate, just shovel whole list 
    students_array << doc.css("roster-cards-container")
    binding.pry
  end    
    # .each do |student_card|  students_array << 

# second layer scrape indiv student profile pages:
# 
  def self.scrape_profile_page(BASE_PATH + student.profile_url)


    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)

  end
end
