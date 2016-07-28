require 'open-uri'
require 'nokogiri' # I added this
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    # stores the HTML of the URL into a variable called html
    # take the string of HTML returned by open-uri's open method and convert it into a NodeSet (aka, a bunch of nested "nodes")
    doc = Nokogiri::HTML(open("http://159.203.117.55:3537/fixtures/student-site/"))
   # selector will allow us to grab index page that lists all of the students
    student_profile=[]
    hash={}
    index = doc.css(".roster-cards-container").each do |student|
      student.css(".student-card a").each do |student_detail|
         hash={name: student_detail.css("h4.student-name").text,
               location: student_detail.css("p.student-location").text,
               profile_url: "./fixtures/student-site/#{student_detail.attr('href')}"}
              # binding.pry
         student_profile << hash
      end
    end
    student_profile
  end

  def self.scrape_profile_page(profile_url)
    # take the string of HTML returned by open-uri's open method and convert it into a NodeSet (aka, a bunch of nested "nodes")
    doc = Nokogiri::HTML(open("http://159.203.117.55:3537/fixtures/student-site/"))
    student_profile=[]
    hash={}
    doc.css(".roster-cards-container").each do |student|
      student.css("div.student-card a").each do |url|
        url
    # 1. holds all the students profiles (div.roster-cards-container)
    # 2. iterate over each student card equal to (div.student-card a)
    # 3. student-profile-key for hash = after iterating take the href of each ("./fixtures/student-site/#{student_detail.attr('href')}")
    # 4. we will be using the href from above to get all our keys which are equal to each students profile
    # 5. div.main-wrapper profile -> vitals container -> social icon container-> hrefs

    # index = doc.css(".roster-cards-container").each do |student|
    #   student.css(".social-icon-container a")["href"]

         binding.pry
        #  student_profile << hash
      end
    end
    # hash
  end

end
