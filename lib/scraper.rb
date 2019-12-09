require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_url = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))
    name = index_url.css(".roster-cards-container").css(".student-name")[0].text
    location = index_url.css(".roster-cards-container").css(".student-location")[0].text
    profile_url = index_url.css(".roster-cards-container").css(".student-card a").map { |link| link['href'] }
    array = []

    index_url.collect do |name, location, profile_url|
      hash = { :name => name, :location => location, :profile_url => profile_url[0] }
      array << hash
    end
        # binding.pry
  end


    # :student_index_array) {[{:name=>"Joe Burgess", :location=>"New York, NY", :profile_url=>"students/joe-burgess.html"},
    #                              {:name=>"Mathieu Balez", :location=>"New York, NY", :profile_url=>"students/mathieu-balez.html"},
    #                              {:name=>"Diane Vu", :location=>"New York, NY", :profile_url=>"students/diane-vu.html"}]}

  def self.scrape_profile_page(profile_url)

  end

end
