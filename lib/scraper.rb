require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    #open
    doc = Nokogiri::HTML(open(index_url))
    #create output_array
    student_index_array = Array.new
    #iterate over element to scrape students info
    doc.css('.student-card').each do |index|
      #first set variable equal to values
      #array << {:name => variable, :location => variable, :student_link => variable}
      student_name = "#{index.css('.student-name').text}"
      student_location = "#{index.css('.student-location').text}"
      #student_url =
      #.push hash notation into array 
      student_index_array.push({:name => student_name, :location => student_location})
    end
  student_index_array 
  end





  def self.scrape_profile_page(profile_url)

  end

end
