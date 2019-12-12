require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_students = []

    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".roster-cards-container")

    students.each do |student|

      hash = { :name => student.css(".student-name")[0].text,
        :location => student.css(".student-location")[0].text,
        :profile_url => student.css(".student-card a.href")[0] }

      scraped_students << hash
      binding.pry
      end
       scraped_students
    end


  def self.scrape_profile_page(profile_url)

  end

end
