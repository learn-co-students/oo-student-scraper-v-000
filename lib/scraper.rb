require 'open-uri'
require 'nokogiri' # I added this
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    # stores the HTML of the URL into a variable called html
    html = open("http://159.203.117.55:3537/fixtures/student-site/")
    # take the string of HTML returned by open-uri's open method and convert it into a NodeSet (aka, a bunch of nested "nodes")
    doc = Nokogiri::HTML(html)
   # selector will allow us to grab index page that lists all of the students
    student_profile=[]
    index = doc.css("div.roster-cards-container").each do |student|
      student.css("div.student_card a").each do |student_detail|
         name_string = student_detail.css("h4.student-name").text,
         location_string = student_detail.css("p.student-location").text,
         profile_url_string =  student_detail.css("div.student-card a").attribute("href").value
         student_profile << {name: name_string, location: location_string, profile_url: profile_url_string}
      # binding.pry
      end
    end
      student_profile
  end

  def self.scrape_profile_page(profile_url)

  end

end
