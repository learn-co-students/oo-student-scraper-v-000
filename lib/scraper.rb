require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".student-card a")
    student_array = students.collect {|student| "#{student.css(".student-name").text}: #{student.css(".student-location").text}: .fixtures/student-site/#{student["href"]}"}
    refined_student_array = student_array.collect {|student| student.split(":").collect {|element| element.to_s.strip}}
    refined_student_array.collect do |name, location, profile_url|
      @student_info = {:name => nil, :location => nil, :profile_url => nil}
      @student_info[:name] = name
      @student_info[:location] = location
      @student_info[:profile_url] = profile_url
      @student_info
    end
  end

  def self.scrape_profile_page(profile_url)
    # binding.pry
  end

end
