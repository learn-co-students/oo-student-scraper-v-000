require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_info = []
    page = Nokogiri::HTML(open(index_url))
    students = page.css(".student-card").css("a")
    test2 = students[0]["href"]
    test3 = students[0].children
    name = students[0].children.css(".student-name").text
    location = students[0].children.css(".student-location").text
    students.to_ary.each { |student|
      student_hash = {}
      student_hash[:name] = student.children.css(".student-name").text
      student_hash[:location] = student.children.css(".student-location").text
      student_hash[:profile_url] = student["href"]
      student_info << student_hash
    }
#    profile = test2.reference a
#    binding.pry
    student_info
    #name = post.css("card-text-container")
    #test_field = post.css("table")

  end

  def self.scrape_profile_page(profile_url)

  end

end

Scraper.scrape_index_page("./fixtures/student-site/index.html")
