require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
      html = open(index_url)
      doc = Nokogiri::HTML(html)
      doc.css(".roster-cards-container").collect do |student|

        # name = project.css(".student-card")
      binding.pry
      # students.each do |student| student_array << student
      #   # student_array
      end
  end

  def self.scrape_profile_page(profile_url)

  end

end
