require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url))

    array = []
    students = doc.css(".roster-cards-container")

    students.each do |student|
      hash = {}
      student.css(".student-name").each do |name|
      name = name.text

      binding.pry
      # hash = { :name => student.css(".student-name").each { |name| name.text }, :location => student.css(".student-location").each { |location| location.text } }
      end

      student.css(".student-location").each do |location|
      location.text
      location
      end

      student.css(".student-card a").map do |link|
      link['href']
      link
      end

      # hash = { :name => name.text, :location => location.text, :profile_url => link['href'] }
      # binding.pry
      end

      # profile_url = doc.css(".roster-cards-container").css(".student-card a").map { |link| link['href'] }

      # index_url.collect do |name, location, profile_url|
      #   hash = { :name => name[0].text, :location => location[0].text, :profile_url => profile_url[0] }
      #   array << hash
        # binding.pry
      # end
    end


      # hash = { :name => student.css(".student-name").text }

      # array << hash




    # location = doc.css(".roster-cards-container").css(".student-location")
    # profile_url = doc.css(".roster-cards-container").css(".student-card a").map { |link| link['href'] }
    # # array = []
    #
    # index_url.collect do |name, location, profile_url|
    #   hash = { :name => name[0].text, :location => location[0].text, :profile_url => profile_url[0] }
    #   array << hash
      # binding.pry
    # end
    # array
        # binding.pry


    # :student_index_array) {[{:name=>"Joe Burgess", :location=>"New York, NY", :profile_url=>"students/joe-burgess.html"},
    #                              {:name=>"Mathieu Balez", :location=>"New York, NY", :profile_url=>"students/mathieu-balez.html"},
    #                              {:name=>"Diane Vu", :location=>"New York, NY", :profile_url=>"students/diane-vu.html"}]}

  def self.scrape_profile_page(profile_url)

  end

end
