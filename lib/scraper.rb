require 'nokogiri'
require 'open-uri' #<---- Ruby module of methods for HTTP requests



class Scraper # does not store information- just scrapes

  def self.scrape_index_page(index_url) # scrape the INDEX page that lists all students
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    Student.name = <h4 class="student-name">blahblahguy</h4>
    Student.location = <p class="student-location">blahplace</p>
    Student.profile_url = <a href="students/blahblahname-lastname.html">..</a>

    # return value should be an array of hashes - each hash is a single student
    # keys ---- :name, :location, :profile_url
    # [:name => "Arthur Carter", :location => "California", :profile_url => "www.him.com"]


  end

  def self.scrape_profile_page(profile_url) # scrape INDIVIDUAL student's profile
    # use NOKOGIRI and OPEN-URI to access page
    # return value should be a hash - key/value pairs describing individual student
    # EDGECASE - some students do not have socialmedia linked up
    # :twitter, :linkedin, :github, :blog, :profile_quote, :bio

  end

end
