require 'open-uri'
require 'pry'
require 'nokogiri'


class Scraper
attr_accessor :name, :location, :profile_url
@@all = []



  def self.scrape_index_page(index_url)
# for each student, parse the name (class 'student-name', location (class 'student-location') profile_url (a href)
html = open("./fixtures/student-site/index.html")
doc = Nokogiri::HTML(open(index_url))

student_name = doc.css(".student-card")
scraped_students = []
 student_name.each do |index|
 scraped_students <<{
  :name => index.css(".student-name").text,
  :location => index.css(".student-location").text,
  :profile_url => index.css("a").attribute("href").value


}

end #.each do
scraped_students
end #self.scrape_index_page(index_url)


  def self.scrape_profile_page(profile_url)
  #  html = open("./fixtures/student-site/index.html")
    doc = Nokogiri::HTML(open(profile_url))
scraped_student = {}

doc.css(".social-icon-container a").each do |link|
  if link["href"].include?("twitter")
         scraped_student[:twitter] = link["href"]
       elsif link["href"].include?("linkedin")
         scraped_student[:linkedin] = link["href"]
       elsif link["href"].include?("github")
         scraped_student[:github] = link["href"]
              elsif scraped_student[:blog] = link["href"]
       end #if statements


  end #.each do
  scraped_student[:profile_quote] = doc.css(".profile-quote").text
scraped_student[:bio] = doc.css(".bio-content .description-holder").text.strip
  scraped_student
end #self.scrape_profile_page(profile_url)
end #class Scraper
