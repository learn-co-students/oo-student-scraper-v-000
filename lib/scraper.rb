require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card")
    # students_collection = []
    #
    # students.each do |student|
    #   student_hash = {}
    #   student_hash[:profile_url] = student.css("a[href]").first.attributes["href"].value
    #   student_hash[:name] = student.css(".student-name").text
    #   student_hash[:location] = student.css(".student-location").text
    #   students_collection << student_hash
    #
    # end
    # students_collection

    students.inject([]) do |acc, student|
      student_hash = {}
      student_hash[:profile_url] = student.css("a[href]").first.attributes["href"].value
      student_hash[:name] = student.css(".student-name").text
      student_hash[:location] = student.css(".student-location").text
      acc << student_hash
    end
  end

  def self.scrape_profile_page(profile_url)

  end

end
