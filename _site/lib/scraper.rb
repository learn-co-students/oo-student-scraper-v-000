
require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :index_url

  def self.scrape_index_page(index_url)
    @index_url = index_url
    create_student_hash
end

  def self.get_page
    doc = Nokogiri::HTML(open(@index_url))
  end

  def self.create_student_hash

    get_page.css("div.student-card").each do |student|
      student_hash = {}
      student_hash[:name] = student.css("h4").text
      student_hash[:location] = student.css("p.student-location").text
      student_hash[:profile_url] = "http://127.0.0.1:4000/students/" + student.css("h4").text.downcase.gsub(" ", "-") + ".html"
      Student.new(student_hash)
    end
    binding.pry
  end

  def self.scrape_profile_page(profile_url)

  end

end

#
# Scraper.scrape_index_page(index_url)
# # => [
# {:name => "Abby Smith", :location => "Brooklyn, NY", :profile_url => "http://127.0.0.1:4000/students/abby-smith.html"},
# {:name => "Joe Jones", :location => "Paris, France", :profile_url => "http://127.0.0.1:4000/students/joe-jonas.html"},
# {:name => "Carlos Rodriguez", :location => "New York, NY", :profile_url => "http://127.0.0.1:4000/students/carlos-rodriguez.html"},
# {:name => "Lorenzo Oro", :location => "Los Angeles, CA", :profile_url => "http://127.0.0.1:4000/students/lorenzo-oro.html"},
# {:name => "Marisa Royer", :location => "Tampa, FL", :profile_url => "http://127.0.0.1:4000/students/marisa-royer.html"}
