require 'open-uri'
require 'pry'

class Scraper

  @all_students = []

  def self.scrape_index_page(index_url)
    student_index_array = []
    html = File.read(index_url)
    student_scraper = Nokogiri::HTML(html)

    student_scraper.css("div.student-card").collect do |s|

      # binding.pry
      # student = s.css("div.card-text-container h4.student-name").text

      each_student = {
        :name => s.css("div.card-text-container h4.student-name").text,
        :location => s.css("div.card-text-container p.student-location").text,
        binding.pry
        :profile_url => "./fixtures/student-site/#{s.css("a").attribute("href").value}"
      }
      student_index_array << each_student

    end

    student_index_array

  end

  def self.scrape_profile_page(profile_url)

  end
end
