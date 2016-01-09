require 'open-uri'
require 'pry'
# require '../spec/vcr/fixtures/index_page.yml'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
	students = Nokogiri::HTML(html)
	students.css("h4.student-name")
	names = students.css("h4.student-name").map {|f| f.text} #name
	locations = students.css("p.student-location").map {|f| f.text}
	links = students.css("div.student-card").map {|f| f.css("a").attribute("href").value}

	array_of_students = []

	until names.empty?
		single_hash = {}
		single_hash[:name] = names.pop
		single_hash[:location] = locations.pop
		single_hash[:profile_url] = "http://students.learn.co/" + links.pop
		array_of_students << single_hash
	end

	array_of_students

	# binding.pry
	# [{:name=>"Joe Burgess", :location=>"New York, NY", :profile_url=>"http://students.learn.co/students/joe-burgess.html"},
 #     {:name=>"Mathieu Balez", :location=>"New York, NY", :profile_url=>"http://students.learn.co/students/mathieu-balez.html"},
 #     {:name=>"Diane Vu", :location=>"New York, NY", :profile_url=>"http://students.learn.co/students/diane-vu.html"}]

  end

  def self.scrape_profile_page(profile_url)
    
  end

end

