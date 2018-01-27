require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    #return: an array of hashes [{name: , location, profile_url: }, {}]
      # each hash represents a single student
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card")
    students_collection = []

    students.each do |student|
      student_hash = {}
      #binding.pry
      student_hash[:name] = student.css(".student-name").text
      student_hash[:location] = student.css(".student-location").text

      students_collection << student_hash
    end
binding.pry
    #for each student: doc.css(/.student-card)
      #create a hash with
        #name:
  end

  def self.scrape_profile_page(profile_url)

  end

end
