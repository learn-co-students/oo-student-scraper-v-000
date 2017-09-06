require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  def self.scrape_index_page(index_url)
    index_doc = Nokogiri::HTML(open(index_url))
    students_hash = {}

    index_doc.css("div.roster-cards-container").each do |student_card|
      student_card = index_doc.css(".student-card a").map do |student|
        students_hash = {
          binding.pry
          :name => student.css(".student-name").text,
          :location => student.css(".student-location").text
        }
        # binding.pry
        # profile_link = "./fixtures/student-site"

        # binding.pry
        # :profile_url => ".fixtures/student-site/students/"

      end
    end
  end


        # Return a hash with individual students
        # all_students

  def self.scrape_profile_page(profile_url)

  end
end
