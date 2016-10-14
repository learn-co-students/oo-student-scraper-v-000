require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  @scraped_students = []


  def self.scrape_index_page(index_url)
    index_url = File.read("./fixtures/student-site/index.html")
    student_index_array = Nokogiri::HTML(index_url)
    student_index_array.css("div.student-card a").each do |student|
      @scraped_students << {
        :name => student.css("div.card-text-container h4.student-name").text,
        :location => student.css("div.card-text-container p.student-location").text,
        :profile_url => student.attribute("href").value.insert(0, "./fixtures/student-site/")
      }
    end
    @scraped_students
  end

  def self.scrape_profile_page(profile_url)
    profile_url_array = @scraped_students.collect do |student_hash|
      student_hash.fetch(:profile_url)
    end

    # profile_url = Nokogiri::HTML(profile_url)

    binding.pry
  end

end
