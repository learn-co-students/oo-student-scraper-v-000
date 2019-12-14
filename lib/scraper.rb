require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

# the return value of this method should be an array of hashes in which each hash represents
# a single student.
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    # students = doc.css(".roster-cards-container")
    students = doc.css(".student-card")
    # binding.pry
    scraped_students = []

    students.each do |student|

      hash = { name: student.css(".student-name")[0].text,
        location: student.css(".student-location")[0].text,
        profile_url: student.css("a")[0]['href'] }
        # binding.pry
      scraped_students << hash
      end
      scraped_students
      # binding.pry
    end

    # The return value
    # of this method should be a hash in which the key/value pairs describe an
    # individual student
  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    students = doc.css(".social-icon-container")

    students.each do |student|
      social_url = { :twitter => student.css("a")[0]['href'] }

    # binding.pry
    end
  end

  # {
  #   :twitter=>"http://twitter.com/flatironschool",
  #   :linkedin=>"https://www.linkedin.com/in/flatironschool",
  #   :github=>"https://github.com/learn-co",
  #   :blog=>"http://flatironschool.com",
  #   :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
  #   :bio=> "I'm a school"
  # }

end
