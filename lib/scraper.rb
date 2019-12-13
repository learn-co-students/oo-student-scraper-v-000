require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper


# the return value of this method should be an array of hashes in which each hash represents
# a single student.
  def self.scrape_index_page(index_url)
    # hash = {}
    scraped_students = []

    doc = Nokogiri::HTML(open(index_url))

    students = doc.css(".roster-cards-container div")
    binding.pry
    students.each do |student|

      hash = { :name => student.css(".student-name")[0].text,
        :location => student.css(".student-location")[0].text,
        :profile_url => student.css(".student-card a")[0]['href'] }

      scraped_students << hash
      # binding.pry
      #  artist_count[artist] += 1
      end
      scraped_students
      # binding.pry
    end


  def self.scrape_profile_page(profile_url)

  end

end
